import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoTutorialsPage extends StatelessWidget {
  const VideoTutorialsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tutoriels vidéos")),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('tutoriels').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

          final docs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;

              return ListTile(
                leading: Icon(Icons.play_circle_fill),
                title: Text(data['titre']),
                subtitle: Text(data['description'] ?? ''),
                onTap: () => launchUrl(Uri.parse(data['url'])),
              );
            },
          );
        },
      ),
    );
  }
}
