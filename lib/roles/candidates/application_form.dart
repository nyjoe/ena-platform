// candidate_application_form.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class CandidateApplicationForm extends StatefulWidget {
  @override
  _CandidateApplicationFormState createState() => _CandidateApplicationFormState();
}

class _CandidateApplicationFormState extends State<CandidateApplicationForm> {
  final _formKey = GlobalKey<FormState>();
  String? _fullName, _email, _motivation;
  File? _cvFile;
  String? _cvDownloadUrl;

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'docx'],
    );

    if (result != null) {
      setState(() {
        _cvFile = File(result.files.single.path!);
      });
    }
  }

  Future<void> _uploadFile() async {
    final user = FirebaseAuth.instance.currentUser;
    if (_cvFile != null && user != null) {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('candidatures/${user.uid}/cv.pdf');

      final uploadTask = await storageRef.putFile(_cvFile!);
      _cvDownloadUrl = await uploadTask.ref.getDownloadURL();
    }
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      await _uploadFile();

      if (_cvDownloadUrl != null) {
        final user = FirebaseAuth.instance.currentUser;

        await FirebaseFirestore.instance
            .collection('candidatures')
            .doc(user!.uid)
            .set({
              'uid': user.uid,
              'nom': _fullName,
              'email': _email,
              'motivation': _motivation,
              'cvUrl': _cvDownloadUrl,
              'statut': 'Soumise',
              'submittedAt': FieldValue.serverTimestamp(),
            });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Candidature envoyée avec succès')),
        );

        Navigator.pop(context); // Retour à l'écran précédent
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de l’upload du CV')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Déposer une candidature")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nom complet'),
                validator: (value) => value!.isEmpty ? 'Ce champ est requis' : null,
                onSaved: (value) => _fullName = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) => value!.contains('@') ? null : 'Email invalide',
                onSaved: (value) => _email = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Lettre de motivation'),
                maxLines: 10,
                onSaved: (value) => _motivation = value,
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _pickFile,
                icon: Icon(Icons.upload_file),
                label: Text(_cvFile == null ? 'Joindre votre CV' : 'CV sélectionné'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Soumettre'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
