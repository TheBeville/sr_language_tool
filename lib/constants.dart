import 'package:flutter/material.dart';

const TextStyle appBarTitleStyling = TextStyle(
  fontSize: 32,
  fontWeight: FontWeight.w900,
  fontStyle: FontStyle.italic,
);

const TextStyle cardInfoStyling = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 18,
  fontStyle: FontStyle.italic,
  color: Colors.lightBlue,
);

const double createCardTextFieldSpace = 10;

enum ReviewRecallDifficulty {
  incorrect,
  difficult,
  reasonable,
  easy,
}
