import 'package:flutter/material.dart';
import 'package:quizzler/boolean_button.dart';
import 'package:quizzler/question.dart';
import 'package:quizzler/question_list.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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
  static const Icon _succeeded = Icon(Icons.check, color: Colors.green);
  static const Icon _failed = Icon(Icons.close, color: Colors.red);

  static const QuestionList _quiz = QuestionList([
    Question('You can lead a cow down stairs but not up stairs.', false),
    Question('Approximately one quarter of human bones are in the feet.', true),
    Question('A slug\'s blood is green.', false),
  ]);

  final List<Icon> _scores = [];
  int get scoresNum => _scores.where((el) => el == _succeeded).length;

  int _questionNumber = 0;
  bool _finished = false;

  void getAnswer(bool choice, bool answer) {
    setState(() {
      if (_finished) {
        getFinalAlert();
        return;
      }

      _scores.add(choice == answer ? _succeeded : _failed);

      if (_questionNumber < _quiz.questions.length - 1) {
        _questionNumber++;
      } else {
        _finished = true;
      }

      if (_finished) {
        getFinalAlert();
      }
    });
  }

  void getFinalAlert() {
    Alert(
      context: context,
      title: "Scores: $scoresNum",
      desc: "You finished! Do you wanna repeat?",
      buttons: [
        DialogButton(
          child: Text('Start Again'),
          onPressed: () {
            setState(() {
              _finished = false;
              _questionNumber = 0;
              _scores.clear();
            });

            Navigator.pop(context);
          },
        ),
      ],
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    String mainText = _finished
        ? 'Final: $scoresNum'
        : _quiz.questions[_questionNumber].text;
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
              () => getAnswer(true, _quiz.questions[_questionNumber].answer),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: BooleanButton(
              'False',
              Colors.red,
              () => getAnswer(false, _quiz.questions[_questionNumber].answer),
            ),
          ),
        ),
        Row(children: _scores),
      ],
    );
  }
}
