// forum/forum_page.dart
import 'package:flutter/material.dart';
import 'forum_room_page.dart';

class ForumPage extends StatelessWidget {
  final forums = ['Général', 'Tests', 'Cours', 'Alumni'];

  ForumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Forum ENA')),
      body: ListView.builder(
        itemCount: forums.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(forums[index]),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ForumRoomPage(forumName: forums[index]),
              ),
            ),
          );
        },
      ),
    );
  }
}
// Compare this snippet from lib/roles/teachers/teacher_mentorship_page.dart:
// // roles/teachers/teacher_mentorship_page.dart