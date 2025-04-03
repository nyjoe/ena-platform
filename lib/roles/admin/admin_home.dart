// roles/admin_home.dart
import 'package:appli_ena/roles/admin/admin_calendar_page.dart';
import 'package:appli_ena/roles/admin/admin_candidature_page.dart';
import 'package:appli_ena/roles/admin/admin_courses_page.dart';
import 'package:appli_ena/roles/admin/admin_users_page.dart';
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
            leading: Icon(Icons.how_to_reg),
            title: Text('Gestion des candidatures'),
            subtitle: Text("Suivre ou trier les candidatures"),
            onTap: () {
              Navigator.push(context,
              MaterialPageRoute(builder: (_) => AdminCandidaturePage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.supervised_user_circle),
            title: Text('Suivi des élèves'),
            subtitle: Text("Gérer les comptes et rôles"),
            onTap: () {
              Navigator.push(context,
              MaterialPageRoute(builder: (_) => AdminUsersPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.event),
            title: Text('Calendrier'),
            subtitle: Text("Ajouter/modifier les événements académiques"),
            onTap: () {
              Navigator.push(context,
              MaterialPageRoute(builder: (_) => AdminCalendarPage()));
            },
          ),
          ListTile(
            leading: Icon(Icons.book),
            title: Text('Cours & Publications'),
            subtitle: Text("Revoir les ressources pédagogiques"),
            onTap: ()  {
              Navigator.push(context,
              MaterialPageRoute(builder: (_) => AdminCoursesPage()));
            }
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Paramètres'),
            subtitle: Text("Maintenance, sécurité (à venir)"),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Section en construction")),
              );
            },
          ),
          // ListTile(
          //   leading: Icon(Icons.settings),
          //   title: Text('Paramètres de l’école'),
          //   onTap: () {},
          // ),
        ],
      ),
    );
  }
}
