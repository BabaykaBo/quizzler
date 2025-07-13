class Question {
  final String _text;
  final bool _answer;

  const Question(this._text, this._answer);

  String get text => _text;
  bool get answer => _answer;
}
