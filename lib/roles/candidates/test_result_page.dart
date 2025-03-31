import 'package:flutter/material.dart';

class TestResultPage extends StatelessWidget {
  const TestResultPage({super.key, required this.score, required this.total});
  final int score;
  final int total;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Résultat du test")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Votre score : $score / $total", style: TextStyle(fontSize: 22)),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Revenir à l’accueil'),
              onPressed: () => Navigator.pop(context),
            )
          ],
        ),
      ),
    );
  }
}
