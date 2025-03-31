// roles/teachers/teacher_course_manage.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TeacherCourseManagePage extends StatefulWidget {
  const TeacherCourseManagePage({super.key});
  @override
  State<StatefulWidget> createState() => _TeacherCourseManagePageState();
}

class _TeacherCourseManagePageState extends State<TeacherCourseManagePage> {
  final _formKey = GlobalKey<FormState>();
  String? _titre, _description, _docUrl;

  void _saveCourse() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance.collection('cours').add({
      'titre': _titre,
      'description': _description,
      'documentUrl': _docUrl,
      'enseignantId': uid,
      'createdAt': FieldValue.serverTimestamp(),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Cours ajouté avec succès !")),
    );
    _formKey.currentState!.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Créer un nouveau cours")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Titre du cours'),
                onSaved: (val) => _titre = val,
                validator: (val) => val!.isEmpty ? 'Obligatoire' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                onSaved: (val) => _description = val,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Lien vers le document (PDF)'),
                onSaved: (val) => _docUrl = val,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    _saveCourse();
                  }
                },
                child: Text("Ajouter"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
