// roles/student_home.dart
import 'package:appli_ena/roles/students/student_calendar_page.dart';
import 'package:appli_ena/roles/students/student_courses_page.dart';
import 'package:appli_ena/roles/students/student_progress_page.dart';
import 'package:flutter/material.dart';

class StudentHome extends StatelessWidget {
  const StudentHome({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Espace Élève')),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.book),
            title: Text('Cours et supports'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => StudentCoursesPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text('Mon calendrier'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => StudentCalendarPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.bar_chart),
            title: Text('Suivi de mes performances'),
            onTap: () {
              Navigator.push(context,
              MaterialPageRoute(builder: (_) => StudentProgressPage()));
            },
          ),
        ],
      ),
    );
  }
}
