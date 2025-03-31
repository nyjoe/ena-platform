// roles/teachers/teacher_evaluations_page.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TeacherEvaluationsPage extends StatefulWidget {
  const TeacherEvaluationsPage({super.key});
  @override
  State<StatefulWidget> createState() => _TeacherEvaluationsPageState();
}

class _TeacherEvaluationsPageState extends State<TeacherEvaluationsPage> {
  final _formKey = GlobalKey<FormState>();
  String? _matiere, _commentaire, _uid;
  double? _note;

  void _enregistrerNote() async {
    await FirebaseFirestore.instance.collection('notes').add({
      'uid': _uid,
      'matiere': _matiere,
      'note': _note,
      'commentaire': _commentaire,
      'timestamp': FieldValue.serverTimestamp(),
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Note enregistrée")),
    );
    _formKey.currentState!.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Évaluer un élève")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'UID de l’élève'),
              onSaved: (val) => _uid = val,
              validator: (val) => val!.isEmpty ? 'Requis' : null,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Matière'),
              onSaved: (val) => _matiere = val,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Note (/20)'),
              keyboardType: TextInputType.number,
              onSaved: (val) => _note = double.tryParse(val!),
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Commentaire'),
              onSaved: (val) => _commentaire = val,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  _enregistrerNote();
                }
              },
              child: Text("Enregistrer"),
            )
          ]),
        ),
      ),
    );
  }
}
