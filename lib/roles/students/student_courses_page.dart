// roles/students/student_courses_page.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class StudentCoursesPage extends StatelessWidget {
  const StudentCoursesPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mes cours")),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('cours').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

          final docs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;
              return ListTile(
                title: Text(data['titre']),
                subtitle: Text(data['description'] ?? ''),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  if (data['documentUrl'] != null) {
                    launchUrl(Uri.parse(data['documentUrl']));
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
