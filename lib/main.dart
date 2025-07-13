import 'package:flutter/material.dart';
import 'package:quizzler/boolean_button.dart';
import 'package:quizzler/question.dart';
import 'package:quizzler/question_list.dart';

void main() => runApp(const Quizzler());

class Quizzler extends StatelessWidget {
  const Quizzler({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quizzler',
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  static const Icon succeeded = Icon(Icons.check, color: Colors.green);
  static const Icon failed = Icon(Icons.close, color: Colors.red);

  static const QuestionList quiz = QuestionList([
    Question('You can lead a cow down stairs but not up stairs.', false),
    Question('Approximately one quarter of human bones are in the feet.', true),
    Question('A slug\'s blood is green.', false),
  ]);

  final List<Icon> scores = [];

  int questionNumber = 0;
  bool finished = false;

  void getAnswer(bool choice, bool answer) {
    setState(() {
      if (finished) {
        return;
      }

      scores.add(choice == answer ? succeeded : failed);

      if (questionNumber < quiz.questions.length - 1) {
        questionNumber++;
      } else {
        finished = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String mainText = finished
        ? 'Final: ${scores.where((el) => el == succeeded).length}'
        : quiz.questions[questionNumber].text;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Text(
                mainText,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: BooleanButton(
              'True',
              Colors.green,
              () => finished
                  ? null
                  : getAnswer(true, quiz.questions[questionNumber].answer),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: BooleanButton(
              'False',
              Colors.red,
              () => finished
                  ? null
                  : getAnswer(false, quiz.questions[questionNumber].answer),
            ),
          ),
        ),
        Row(children: scores),
      ],
    );
  }
}
