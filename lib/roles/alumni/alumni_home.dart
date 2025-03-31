// roles/alumni_home.dart
import 'package:flutter/material.dart';

class AlumniHome extends StatelessWidget {
  const AlumniHome({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Espace Alumni')),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.people),
            title: Text('Annuaire des alumni'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.school_outlined),
            title: Text('Mentorat & Réseautage'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.public),
            title: Text('Contributions & publications'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
