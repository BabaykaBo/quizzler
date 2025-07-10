import 'package:flutter/material.dart';

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

  static const List<(String, bool)> questions = [
    ('You can lead a cow down stairs but not up stairs.', false),
    ('Approximately one quarter of human bones are in the feet.', true),
    ('A slug\'s blood is green.', false),
  ];

  final List<Icon> scores = [];
  
  int questionNumber = 0;
  bool finished = false;

  void getAnswer(bool choice, bool answer) {
    setState(() {
      if (finished) {
        return;
      }

      scores.add(choice == answer ? succeeded : failed);
      
      if (questionNumber < questions.length - 1) {
        questionNumber++;
      } else {
        finished = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
                finished ? 'Final' : questions[questionNumber].$1,
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
              () => getAnswer(true, questions[questionNumber].$2),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: BooleanButton(
              'False',
              Colors.red,
              () => getAnswer(false, questions[questionNumber].$2),
            ),
          ),
        ),
        Row(children: scores),
      ],
    );
  }
}

class BooleanButton extends StatelessWidget {
  final String text;
  final Color color;
  final Function call;

  const BooleanButton(this.text, this.color, this.call, {super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(color)),
      onPressed: () => call(),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}
