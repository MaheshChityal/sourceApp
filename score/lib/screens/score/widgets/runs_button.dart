import 'package:flutter/material.dart';

class RunsButton extends StatelessWidget {
  const RunsButton({
    super.key,
    required this.runText,
    required this.onPressed,
  });

  final String runText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1.5),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          minimumSize: Size(0, 65),
          shape: const CircleBorder(),
          side: BorderSide(width: 2, color: Color.fromARGB(255, 24, 132, 28)),
        ),
        onPressed: onPressed,
        child: Text(
          runText,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
