// roles/admin_courses_page.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class AdminCoursesPage extends StatelessWidget {
  AdminCoursesPage({super.key});
  final _collection = FirebaseFirestore.instance.collection('cours');

  Future<void> _changerStatut(BuildContext context, String id, String nouveauStatut) async {
    await _collection.doc(id).update({'statut': nouveauStatut});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Cours marqué comme '$nouveauStatut'")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cours & publications enseignants")),
      body: StreamBuilder<QuerySnapshot>(
        stream: _collection.orderBy('createdAt', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

          final cours = snapshot.data!.docs;

          if (cours.isEmpty) return Center(child: Text("Aucun cours à afficher."));

          return ListView.builder(
            itemCount: cours.length,
            itemBuilder: (context, index) {
              final data = cours[index].data() as Map<String, dynamic>;
              final docId = cours[index].id;
              final titre = data['titre'] ?? 'Sans titre';
              final description = data['description'] ?? '';
              final docUrl = data['documentUrl'];
              final statut = data['statut'] ?? 'en_attente';

              return Card(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  title: Text(titre),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(description),
                      SizedBox(height: 4),
                      Text("Statut : $statut", style: TextStyle(fontStyle: FontStyle.italic)),
                      if (docUrl != null)
                        InkWell(
                          onTap: () => launchUrl(Uri.parse(docUrl)),
                          child: Text("📎 Voir le document",
                            style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline)),
                        ),
                    ],
                  ),
                  trailing: PopupMenuButton<String>(
                    onSelected: (val) => _changerStatut(context, docId, val),
                    itemBuilder: (context) => [
                      PopupMenuItem(value: 'approuve', child: Text('✅ Approuver')),
                      PopupMenuItem(value: 'rejete', child: Text('❌ Rejeter')),
                    ],
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
