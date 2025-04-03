// roles/candidate_home.dart
import 'package:appli_ena/roles/candidates/application_form.dart';
import 'package:appli_ena/roles/candidates/test_simulation_page.dart';
import 'package:appli_ena/tutos/video_tutorials_page.dart';
import 'package:flutter/material.dart';

class CandidateHome extends StatefulWidget {
  const CandidateHome({super.key});
  @override
  State<StatefulWidget> createState() => _CandidateDashboardState();
}

class _CandidateDashboardState extends State<CandidateHome> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    CandidateApplicationForm(),
    TestSimulationPage(),
    VideoTutorialsPage(),
    Center(child: Text('Paramètres à venir')),
  ];

  final List<String> _titles = [
    'Dépôt de candidature',
    'Préparation au test',
    'Tutoriels vidéos',
    'Paramètres'
  ];

  void _navigateTo(int index) {
    setState(() {
      _currentIndex = index;
      Navigator.pop(context); // Ferme le drawer
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Espace Futurs Elèves')),
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
              title: Text(_titles[0]),
              subtitle: Text("Remplir le formulaire d'inscription", style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),),
              onTap: () => _navigateTo(0),
            ),
            ListTile(
              leading: Icon(Icons.event),
              title: Text(_titles[1]),
              subtitle: Text("Simulateur de test d'admission", style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),),
              onTap: () => _navigateTo(1),
            ),
            ListTile(
              leading: Icon(Icons.book),
              title: Text(_titles[2]), // Tutoriels vidéos
              subtitle: Text("Ressources pédagogiques", style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),),
              onTap: () => _navigateTo(2),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(_titles[3]), // Paramètres
              onTap: () {
                // Settings
              },
            ),
          ],
        ),
      ),
      body : _pages[_currentIndex],
      

    // ListTile(
    //   leading: Icon(Icons.picture_as_pdf),
    //   title: Text('Annales d’examen'),
    //   onTap: () {
    //     Navigator.push(context,
    //       MaterialPageRoute(builder: (_) => ExamAnnalsPage()));
    //   },
    // )
    );
  }
}
