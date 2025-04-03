// roles/admin/admin_home.dart
//import 'package:appli_ena/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'admin_candidature_page.dart';
import 'admin_users_page.dart';
import 'admin_calendar_page.dart';
import 'admin_courses_page.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});
  @override
  State<StatefulWidget> createState() => _AdminDashboardState();

}

class _AdminDashboardState extends State<AdminDashboard> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    AdminCandidaturePage(),
    AdminUsersPage(),
    AdminCalendarPage(),
    AdminCoursesPage(),
    Center(child: Text('Paramètres à venir')),
  ];

  final List<String> _titles = [
    'Candidatures',
    'Utilisateurs',
    'Calendrier',
    'Cours & Publications',
    'Paramètres'
  ];

  void _navigateTo(int index) {
    setState(() {
      _currentIndex = index;
      Navigator.pop(context); // Ferme le drawer
    });
  }

  @override
  void initState() {
    super.initState();
    //_initNotifications(); // Initialisation des notifications
  }

  // void _initNotifications() async {
  //   FirebaseMessaging messaging = FirebaseMessaging.instance;

  //   NotificationSettings settings = await messaging.requestPermission();
  //   print('🔔 Permission: ${settings.authorizationStatus}');

  //   // Token de test (à utiliser pour envoyer des notifs depuis Firebase console)
  //   String? token = await messaging.getToken();
  //   print('🔑 Token FCM: $token');

  //   // Lorsqu'app en 1er plan
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     final notification = message.notification;
  //     if (notification != null) {
  //       flutterLocalNotificationsPlugin.show(
  //         0,
  //         notification.title,
  //         notification.body,
  //         const NotificationDetails(
  //           android: AndroidNotificationDetails(
  //             'default_channel',
  //             'Notifications ENA',
  //             importance: Importance.max,
  //             priority: Priority.high,
  //           ),
  //         ),
  //       );
  //     }
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        title: Text(_titles[_currentIndex]),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              // Logique de déconnexion ici
              Navigator.pop(context); // Ferme le drawer
              await FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.indigo),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.admin_panel_settings, color: Colors.white, size: 48),
                  SizedBox(height: 8),
                  Text("Admin ENA",
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.how_to_reg),
              title: Text('Candidatures'),
              onTap: () => _navigateTo(0),
            ),
            ListTile(
              leading: Icon(Icons.group),
              title: Text('Utilisateurs'),
              onTap: () => _navigateTo(1),
            ),
            ListTile(
              leading: Icon(Icons.event),
              title: Text('Calendrier'),
              onTap: () => _navigateTo(2),
            ),
            ListTile(
              leading: Icon(Icons.book),
              title: Text('Cours & Publications'),
              onTap: () => _navigateTo(3),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Paramètres'),
              onTap: () => _navigateTo(4),
            ),
          ],
        ),
      ),
      body: _pages[_currentIndex],
    );
  }
}










// import 'package:appli_ena/roles/admin/admin_candidature_details.dart';
// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class AdminCandidaturesDashboard extends StatelessWidget {
//   const AdminCandidaturesDashboard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Tableau de bord administratif')),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection('candidatures').snapshots(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

//           final candidatures = snapshot.data!.docs;

//           return ListView.builder(
//             itemCount: candidatures.length,
//             itemBuilder: (context, index) {
//               final data = candidatures[index].data() as Map<String, dynamic>;
//               final docId = candidatures[index].id;

//               return Card(
//                 margin: EdgeInsets.all(8),
//                 child: ListTile(
//                   title: Text(data['nom'] ?? 'Sans nom'),
//                   subtitle: Text('Statut : ${data['statut']}'),
//                   trailing: IconButton(
//                     icon: Icon(Icons.edit),
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => AdminCandidatureDetails(docId: docId, data: data),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
