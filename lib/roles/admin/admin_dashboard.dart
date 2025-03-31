// roles/admin_home.dart
import 'package:appli_ena/roles/admin/admin_candidature_details.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminCandidaturesDashboard extends StatelessWidget {
  const AdminCandidaturesDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tableau de bord administratif')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('candidatures').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

          final candidatures = snapshot.data!.docs;

          return ListView.builder(
            itemCount: candidatures.length,
            itemBuilder: (context, index) {
              final data = candidatures[index].data() as Map<String, dynamic>;
              final docId = candidatures[index].id;

              return Card(
                margin: EdgeInsets.all(8),
                child: ListTile(
                  title: Text(data['nom'] ?? 'Sans nom'),
                  subtitle: Text('Statut : ${data['statut']}'),
                  trailing: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => AdminCandidatureDetails(docId: docId, data: data),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
