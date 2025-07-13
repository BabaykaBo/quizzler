import 'package:flutter/material.dart';

class BooleanButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback call;

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
