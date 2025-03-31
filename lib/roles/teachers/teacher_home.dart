// roles/teacher_home.dart
import 'package:appli_ena/roles/teachers/teacher_course_manage.dart';
import 'package:appli_ena/roles/teachers/teacher_evaluations_page.dart';
import 'package:appli_ena/roles/teachers/teacher_mentorship_page.dart';
import 'package:flutter/material.dart';

class TeacherHome extends StatelessWidget {
  const TeacherHome({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Espace Enseignant')),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.folder_shared),
            title: Text('Gérer mes cours'),
            onTap: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (_) => TeacherCourseManagePage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.assignment_turned_in),
            title: Text('Évaluations'),
            onTap: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (_) => TeacherEvaluationsPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.chat),
            title: Text('Messagerie élève'),
            onTap: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (_) => TeacherMentorshipPage()));
            },
          ),
        ],
      ),
    );
  }
}
