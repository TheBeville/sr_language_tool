import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sr_language_tool/constants.dart';
import 'package:sr_language_tool/models/database.dart' as database_model;
import 'package:sr_language_tool/services/card_cubit.dart';
import 'package:sr_language_tool/services/review_session_cubit.dart';
import 'package:sr_language_tool/widgets/review_difficulty_button.dart';
import 'package:sr_language_tool/widgets/viewable_card.dart';

class ReviewCardPage extends StatefulWidget {
  const ReviewCardPage({required this.selectedLanguage, super.key});
  final String selectedLanguage;

  @override
  State<ReviewCardPage> createState() => _ReviewCardPageState();
}

class _ReviewCardPageState extends State<ReviewCardPage> {
  int currentCardIndex = 0;
  bool showFullCard = false;

  @override
  void initState() {
    super.initState();
    context
        .read<ReviewSessionCubit>()
        .getDueCardsOfLang(widget.selectedLanguage);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Reviewing: ${widget.selectedLanguage}'),
        ),
        body: BlocBuilder<ReviewSessionCubit, List<database_model.Card>>(
          builder: (context, dueCards) {
            void onPressed(ReviewRecallDifficulty difficulty) {
              context.read<ReviewSessionCubit>().updateCardReviewStatus(
                    cardId: dueCards[currentCardIndex].id,
                    lastReview: dueCards[currentCardIndex].lastReview,
                    nextReviewDue: dueCards[currentCardIndex].nextReviewDue,
                    difficulty: difficulty,
                  );
              context.read<CardCubit>().getCardsOfLang(widget.selectedLanguage);
              setState(() {
                currentCardIndex++;
                showFullCard = false;
              });
            }

            if (dueCards.isEmpty || currentCardIndex >= dueCards.length) {
              return Center(child: Text('No cards to review'));
            } else {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    showFullCard = !showFullCard;
                  });
                },
                child: Center(
                  child: showFullCard
                      ? Column(
                          children: [
                            Expanded(
                              child: Center(
                                child: ViewableCard(
                                  card: dueCards[currentCardIndex],
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // INCORRECT BUTTON
                                ReviewDifficultyButton(
                                  label: 'Incorrect',
                                  color: Colors.red,
                                  onPressed: () => onPressed(
                                    ReviewRecallDifficulty.incorrect,
                                  ),
                                ),

                                // DIFFICULT BUTTON
                                ReviewDifficultyButton(
                                  label: 'Difficult',
                                  color: Colors.orange,
                                  onPressed: () => onPressed(
                                    ReviewRecallDifficulty.difficult,
                                  ),
                                ),

                                // REASONABLE BUTTON
                                ReviewDifficultyButton(
                                  label: 'Reasonable',
                                  color: Colors.green,
                                  onPressed: () => onPressed(
                                    ReviewRecallDifficulty.reasonable,
                                  ),
                                ),

                                // EASY BUTTON
                                ReviewDifficultyButton(
                                  label: 'Easy',
                                  color: Colors.blue,
                                  onPressed: () => onPressed(
                                    ReviewRecallDifficulty.easy,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                          ],
                        )
                      : Text(
                          dueCards[currentCardIndex].frontContent,
                          style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
