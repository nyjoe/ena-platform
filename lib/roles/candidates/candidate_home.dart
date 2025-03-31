// roles/candidate_home.dart
import 'package:appli_ena/roles/candidates/application_form.dart';
import 'package:appli_ena/roles/candidates/test_simulation_page.dart';
import 'package:appli_ena/tutos/video_tutorials_page.dart';
import 'package:flutter/material.dart';

class CandidateHome extends StatelessWidget {
  const CandidateHome({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Espace Candidat')),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.assignment),
            title: Text('Déposer une candidature'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => CandidateApplicationForm()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.track_changes),
            title: Text('Suivi de la candidature'),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.school),
            title: Text('Préparation au test'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => TestSimulationPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.play_circle_fill),
            title: Text('Tutoriels vidéos'),
            onTap: () {
              Navigator.push(context,
                MaterialPageRoute(builder: (_) => VideoTutorialsPage()));
            },
          ),
          // ListTile(
          //   leading: Icon(Icons.picture_as_pdf),
          //   title: Text('Annales d’examen'),
          //   onTap: () {
          //     Navigator.push(context,
          //       MaterialPageRoute(builder: (_) => ExamAnnalsPage()));
          //   },
          // ),
        ],
      ),
    );
  }
}
