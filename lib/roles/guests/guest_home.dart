// roles/guest_home.dart
import 'package:flutter/material.dart';

class GuestHome extends StatelessWidget {
  const GuestHome({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bienvenue à l’ENA')),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.info),
            title: Text('À propos de l’École'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.event),
            title: Text('Événements & actualités'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.article),
            title: Text('Publications en accès libre'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
