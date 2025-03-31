// roles/admin/admin_candidature_details.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class AdminCandidatureDetails extends StatefulWidget {
  const AdminCandidatureDetails({super.key, required this.docId, required this.data});
  final String docId;
  final Map<String, dynamic> data;


  @override
  State<StatefulWidget> createState() => _AdminCandidatureDetailsState();
}

class _AdminCandidatureDetailsState extends State<AdminCandidatureDetails> {
  late String _statut;

  @override
  void initState() {
    super.initState();
    _statut = widget.data['statut'];
  }

  Future<void> _updateStatut(String newStatus) async {
    await FirebaseFirestore.instance
        .collection('candidatures')
        .doc(widget.docId)
        .update({'statut': newStatus});

    setState(() => _statut = newStatus);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Statut mis à jour en "$newStatus"'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.data;

    return Scaffold(
      appBar: AppBar(title: Text('Détails de la candidature')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Nom : ${data['nom']}"),
            Text("Email : ${data['email']}"),
            Text("Motivation :\n${data['motivation'] ?? ''}"),
            SizedBox(height: 10),
            InkWell(
              onTap: () => launchUrl(Uri.parse(data['cvUrl'])),
              child: Text(
                'Voir le CV',
                style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
              ),
            ),
            SizedBox(height: 20),
            Text("Statut actuel : $_statut"),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () => _updateStatut('Acceptée'),
                  child: Text('Accepter'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => _updateStatut('Rejetée'),
                  child: Text('Rejeter'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
