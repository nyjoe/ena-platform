// roles/admin_users_page.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminUsersPage extends StatelessWidget {
  AdminUsersPage({super.key});
  final List<String> roles = ['candidat', 'eleve', 'enseignant', 'admin', 'alumni'];

  void _changerRole(BuildContext context, String uid, String nouveauRole) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).update({'role': nouveauRole});
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Rôle mis à jour en $nouveauRole")));
  }

  void _supprimerUtilisateur(BuildContext context, String uid) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).delete();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Utilisateur supprimé de Firestore")));
  }

  @override
  Widget build(BuildContext context) {
    final usersStream = FirebaseFirestore.instance.collection('users').snapshots();

    return Scaffold(
      appBar: AppBar(title: Text('Gestion des utilisateurs')),
      body: StreamBuilder<QuerySnapshot>(
        stream: usersStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

          final docs = snapshot.data!.docs;

          if (docs.isEmpty) return Center(child: Text("Aucun utilisateur trouvé."));

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final user = docs[index].data() as Map<String, dynamic>;
              final uid = docs[index].id;

              return Card(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  title: Text(user['email'] ?? 'Email inconnu'),
                  subtitle: Text("Rôle : ${user['role']}"),
                  trailing: PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'supprimer') {
                        _supprimerUtilisateur(context, uid);
                      } else {
                        _changerRole(context, uid, value);
                      }
                    },
                    itemBuilder: (context) => [
                      ...roles.map((r) => PopupMenuItem(value: r, child: Text("Changer rôle → $r"))),
                      PopupMenuDivider(),
                      PopupMenuItem(value: 'supprimer', child: Text("❌ Supprimer")),
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
