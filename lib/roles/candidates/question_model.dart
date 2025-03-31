class Question {
  final String question;
  final List<String> options;
  final int correctIndex;

  Question({
    required this.question,
    required this.options,
    required this.correctIndex,
  });
}
// List of questions 
// List<Question> questions = [
//   Question(
//     question: 'Quel est le langage de programmation utilisé pour développer des applications Flutter ?',
//     options: ['Dart', 'Java', 'Python', 'C++'],
//     correctIndex: 0,
//   ),
//   Question(
//     question: 'Quel widget Flutter est utilisé pour afficher une image ?',
//     options: ['Image', 'Picture', 'Photo', 'Graph'],
//     correctIndex: 0,
//   ),
//   Question(
//     question: 'Quel est le but de la fonction main() dans une application Flutter ?',
//     options: [
//       'Initialiser l\'application',
//       'Afficher l\'interface utilisateur',
//       'Gérer les événements',
//       'Aucune de ces réponses'
//     ],
//     correctIndex: 0,
//   ),
// ];