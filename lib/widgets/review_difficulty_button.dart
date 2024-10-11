import 'package:flutter/material.dart';

class ReviewDifficultyButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onPressed;

  const ReviewDifficultyButton({
    super.key,
    required this.label,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      textColor: color,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      child: Text(
        label,
        style: TextStyle(fontSize: 16.0),
      ),
    );
  }
}
