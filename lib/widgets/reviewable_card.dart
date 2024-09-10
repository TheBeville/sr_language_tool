import 'package:flutter/material.dart';
import 'package:sr_language_tool/models/database.dart' as database_model;

class ReviewableCard extends StatelessWidget {
  const ReviewableCard({
    required this.dBCard,
    required this.userHasTapped,
    super.key,
  });

  final database_model.Card dBCard;
  final bool userHasTapped;

  @override
  Widget build(BuildContext context) {
    return !userHasTapped
        ? GestureDetector(
            onTap: () {},
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(dBCard.frontContent),
              ],
            ),
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Text(dBCard.frontContent),
              const Divider(height: 1),
              Text(dBCard.revealContent),
              const Spacer(),
              Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, style: BorderStyle.solid),
                    ),
                    child: const Column(
                      children: [
                        Text(
                          'Incorrect',
                          style: TextStyle(color: Colors.red),
                        ),
                        Text('review date'),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, style: BorderStyle.solid),
                    ),
                    child: const Column(
                      children: [
                        Text(
                          'Difficult',
                          style: TextStyle(color: Colors.amber),
                        ),
                        Text('review date'),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, style: BorderStyle.solid),
                    ),
                    child: const Column(
                      children: [
                        Text(
                          'Correct',
                          style: TextStyle(color: Colors.green),
                        ),
                        Text('review date'),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, style: BorderStyle.solid),
                    ),
                    child: const Column(
                      children: [
                        Text(
                          'Easy',
                          style: TextStyle(color: Colors.blue),
                        ),
                        Text('review date'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          );
  }
}
