import 'package:quizzler/question.dart';

class QuestionList {
  final List<Question> _questions;
  const QuestionList(this._questions);

  List<Question> get questions => _questions;
}
