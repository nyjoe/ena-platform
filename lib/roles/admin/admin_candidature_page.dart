// roles/admin/admin_candidature_page.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class AdminCandidaturePage extends StatelessWidget {
  const AdminCandidaturePage({super.key});
  @override
  Widget build(BuildContext context) {
    final candidaturesStream = FirebaseFirestore.instance
    .collection('candidatures')
    .orderBy('submittedAt', descending: true)
    .snapshots();

    return Scaffold(
      appBar: AppBar(title: Text('Gestion des candidatures')),
      body: StreamBuilder<QuerySnapshot>(
        stream: candidaturesStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

          final docs = snapshot.data!.docs;

          if (docs.isEmpty) {
            return Center(child: Text("Aucune candidature pour le moment."));
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;
              final docId = docs[index].id;

              return Card(
                margin: EdgeInsets.all(8),
                child: ListTile(
                  title: Text(data['nom'] ?? 'Sans nom'),
                  subtitle: Text("Statut : ${data['statut']}"),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AdminCandidatureDetails(docId: docId, data: data),
                    ),
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

class AdminCandidatureDetails extends StatefulWidget {
  final String docId;
  final Map<String, dynamic> data;

  const AdminCandidatureDetails({super.key, required this.docId, required this.data});

  @override
  State<StatefulWidget> createState() => _AdminCandidatureDetailsState();
}

class _AdminCandidatureDetailsState extends State<AdminCandidatureDetails> {
  late String _statut;

  @override
  void initState() {
    super.initState();
    _statut = widget.data['statut'] ?? 'Soumise';
  }

  Future<void> _updateStatut(String newStatut) async {
    await FirebaseFirestore.instance
        .collection('candidatures')
        .doc(widget.docId)
        .update({'statut': newStatut});

    setState(() {
      _statut = newStatut;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Statut mis à jour en '$newStatut'")),
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.data;

    return Scaffold(
      appBar: AppBar(title: Text("Détails de la candidature")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Nom : ${data['nom']}", style: TextStyle(fontSize: 18)),
            Text("Email : ${data['email']}"),
            SizedBox(height: 10),
            Text("Lettre de motivation :", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(data['motivation'] ?? "-"),
            SizedBox(height: 10),
            if (data['cvUrl'] != null)
              InkWell(
                onTap: () => launchUrl(Uri.parse(data['cvUrl'])),
                child: Text(
                  '📎 Voir le CV',
                  style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                ),
              ),
            Divider(height: 30),
            Text("Statut actuel : $_statut"),
            SizedBox(height: 10),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () => _updateStatut('Acceptée'),
                  child: Text("✅ Accepter"),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => _updateStatut('Rejetée'),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: Text("❌ Rejeter"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
