// roles/admin_home.dart
import 'package:flutter/material.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Espace Administration')),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.manage_accounts),
            title: Text('Gérer les candidatures'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.supervised_user_circle),
            title: Text('Suivi des élèves'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Paramètres de l’école'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
