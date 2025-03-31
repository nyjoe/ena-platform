// forum/forum_room_page.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForumRoomPage extends StatefulWidget {
  const ForumRoomPage({super.key, required this.forumName});
  final String forumName;

  @override
  State<StatefulWidget> createState() => _ForumRoomPageState();
}

class _ForumRoomPageState extends State<ForumRoomPage> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  final controller = TextEditingController();

  void _postMessage() {
    final text = controller.text.trim();
    if (text.isNotEmpty) {
      FirebaseFirestore.instance
          .collection('forums')
          .doc(widget.forumName)
          .collection('messages')
          .add({
        'text': text,
        'from': uid,
        'sentAt': FieldValue.serverTimestamp()
      });
      controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Forum : ${widget.forumName}")),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('forums')
                  .doc(widget.forumName)
                  .collection('messages')
                  .orderBy('sentAt')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();

                return ListView(
                  children: snapshot.data!.docs.map((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    return ListTile(
                      title: Text(data['text']),
                      subtitle: Text("De : ${data['from']}"),
                    );
                  }).toList(),
                );
              },
            ),
          ),
          Divider(height: 1),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Expanded(child: TextField(controller: controller)),
                IconButton(icon: Icon(Icons.send), onPressed: _postMessage),
              ],
            ),
          )
        ],
      ),
    );
  }
}
