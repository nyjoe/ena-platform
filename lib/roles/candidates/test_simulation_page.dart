import 'package:flutter/material.dart';
import 'question_model.dart';
import 'test_result_page.dart';

class TestSimulationPage extends StatefulWidget {
  const TestSimulationPage({super.key});
  static const String routeName = '/test-simulation';
  @override
  State<StatefulWidget> createState() => _TestSimulationPageState();
}

class _TestSimulationPageState extends State<TestSimulationPage> {
  int currentIndex = 0;
  int score = 0;
  List<int?> answers = [];

  final List<Question> questions = [
    Question(
      question: 'Quelle est la capitale de la RDC ?',
      options: ['Goma', 'Kinshasa', 'Lubumbashi', 'Bukavu'],
      correctIndex: 1,
    ),
    Question(
      question: 'Combien d’étoiles sur le drapeau de l’UE ?',
      options: ['10', '15', '12', '20'],
      correctIndex: 2,
    ),
  ];

  void nextQuestion() {
    if (answers[currentIndex] == questions[currentIndex].correctIndex) {
      score++;
    }

    if (currentIndex < questions.length - 1) {
      setState(() => currentIndex++);
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => TestResultPage(score: score, total: questions.length),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    answers = List.filled(questions.length, null);
  }

  @override
  Widget build(BuildContext context) {
    final q = questions[currentIndex];

    return Scaffold(
      appBar: AppBar(title: Text("Simulateur de test")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(q.question, style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ...List.generate(q.options.length, (i) {
              return RadioListTile<int>(
                title: Text(q.options[i]),
                value: i,
                groupValue: answers[currentIndex],
                onChanged: (val) {
                  setState(() {
                    answers[currentIndex] = val;
                  });
                },
              );
            }),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: answers[currentIndex] != null ? nextQuestion : null,
              child: Text(currentIndex == questions.length - 1
                  ? 'Voir résultat'
                  : 'Suivant'),
            )
          ],
        ),
      ),
    );
  }
}
