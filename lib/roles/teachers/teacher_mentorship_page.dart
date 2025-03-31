// roles/teachers/teacher_mentorship_page.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TeacherMentorshipPage extends StatelessWidget {
  TeacherMentorshipPage({super.key});
  final String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mes élèves mentorés')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('mentorat')
            .where('enseignantId', isEqualTo: uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

          final mentores = snapshot.data!.docs;

          if (mentores.isEmpty) {
            return Center(child: Text('Aucun élève mentoré pour le moment.'));
          }

          return ListView.builder(
            itemCount: mentores.length,
            itemBuilder: (context, index) {
              final data = mentores[index].data() as Map<String, dynamic>;

              return ListTile(
                leading: Icon(Icons.person),
                title: Text(data['nom']),
                subtitle: Text(data['email']),
                trailing: Icon(Icons.chat),
                onTap: () {
                  // On pourra lancer une messagerie directe ici
                },
              );
            },
          );
        },
      ),
    );
  }
}
