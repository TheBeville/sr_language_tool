import 'package:flutter/material.dart';
import 'package:sr_language_tool/constants.dart';
import 'package:sr_language_tool/locator.dart';
import 'package:sr_language_tool/models/database.dart' as database_model;
import 'package:sr_language_tool/services/database_service.dart';

class ReviewableCard extends StatefulWidget {
  const ReviewableCard({
    required this.card,
    required this.userHasTapped,
    super.key,
  });

  final database_model.Card card;
  final bool userHasTapped;

  @override
  State<ReviewableCard> createState() => _ReviewableCardState();
}

class _ReviewableCardState extends State<ReviewableCard> {
  final dBService = locator.get<DatabaseService>();

  @override
  Widget build(BuildContext context) {
    bool hasTapped = widget.userHasTapped;

    return !hasTapped
        ? GestureDetector(
            onTap: () {
              dBService.updateLastReview(widget.card.id, DateTime.now());
              dBService.updateNextReviewDue(
                widget.card.id,
                DateTime.now().add(
                  const Duration(days: 1),
                ),
              );
              // TODO: hasTapped property changes, but resets on UI rebuild
              setState(() {
                hasTapped = true;
              });
            },
            child: Center(
              child: Text(
                widget.card.frontContent,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Spacer(),
              Text(
                widget.card.frontContent,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                width: 342,
                height: 1,
                child: Divider(
                  height: 25,
                  thickness: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  children: [
                    FutureBuilder<String?>(
                      future: dBService.getCatByID(widget.card.category),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData || snapshot.data == null) {
                          return const Text('Cat. not found');
                        } else {
                          return Text(
                            '[${snapshot.data!}]',
                            style: cardInfoStyling,
                          );
                        }
                      },
                    ),
                    const SizedBox(width: 2),
                    widget.card.gender == null
                        ? const SizedBox()
                        : Text(
                            '[${widget.card.gender}]',
                            style: cardInfoStyling,
                          ),
                    const SizedBox(width: 2),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Text(
                widget.card.revealContent,
                style: const TextStyle(fontSize: 28),
              ),
              widget.card.pluralForm == null
                  ? const SizedBox(height: 30)
                  : Column(
                      children: [
                        Text(
                          '(plural: ${widget.card.pluralForm})',
                          style: cardInfoStyling,
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
              const Spacer(),
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.stretch,
              //   children: [
              //     Container(
              //       decoration: BoxDecoration(
              //         border: Border.all(width: 1, style: BorderStyle.solid),
              //       ),
              //       child: const Column(
              //         children: [
              //           Text(
              //             'Incorrect',
              //             style: TextStyle(color: Colors.red),
              //           ),
              //           Text('review date'),
              //         ],
              //       ),
              //     ),
              //     Container(
              //       decoration: BoxDecoration(
              //         border: Border.all(width: 1, style: BorderStyle.solid),
              //       ),
              //       child: const Column(
              //         children: [
              //           Text(
              //             'Difficult',
              //             style: TextStyle(color: Colors.amber),
              //           ),
              //           Text('review date'),
              //         ],
              //       ),
              //     ),
              //     Container(
              //       decoration: BoxDecoration(
              //         border: Border.all(width: 1, style: BorderStyle.solid),
              //       ),
              //       child: const Column(
              //         children: [
              //           Text(
              //             'Correct',
              //             style: TextStyle(color: Colors.green),
              //           ),
              //           Text('review date'),
              //         ],
              //       ),
              //     ),
              //     Container(
              //       decoration: BoxDecoration(
              //         border: Border.all(width: 1, style: BorderStyle.solid),
              //       ),
              //       child: const Column(
              //         children: [
              //           Text(
              //             'Easy',
              //             style: TextStyle(color: Colors.blue),
              //           ),
              //           Text('review date'),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
              Text(
                'Last reviewed: ${widget.card.lastReview}',
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 10),
            ],
          );
  }
}
