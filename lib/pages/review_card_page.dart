import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sr_language_tool/locator.dart';
import 'package:sr_language_tool/models/database.dart' as database_model;
import 'package:sr_language_tool/services/card_cubit.dart';
import 'package:sr_language_tool/services/database_service.dart';
import 'package:sr_language_tool/services/review_session_cubit.dart';
import 'package:sr_language_tool/widgets/reviewable_card.dart';

class ReviewCardPage extends StatefulWidget {
  const ReviewCardPage({required this.selectedLanguage, super.key});
  final String selectedLanguage;

  @override
  State<ReviewCardPage> createState() => _ReviewCardPageState();
}

class _ReviewCardPageState extends State<ReviewCardPage> {
  final dB = locator.get<database_model.AppDatabase>();
  final dBService = locator.get<DatabaseService>();

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
            if (dueCards.isEmpty) {
              return Text('Loading...');
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
                                child: ReviewableCard(
                                  card: dueCards[currentCardIndex],
                                  userHasTapped: true,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                MaterialButton(
                                  onPressed: () {
                                    context
                                        .read<ReviewSessionCubit>()
                                        .updateCardReviewStatus(
                                          cardId: dueCards[currentCardIndex].id,
                                          isCorrect: false,
                                        );
                                    context.read<CardCubit>().getCardList();
                                    setState(() {
                                      currentCardIndex++;
                                      showFullCard = false;
                                    });
                                  },
                                  child: Text(
                                    'Incorrect',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                MaterialButton(
                                  onPressed: () {
                                    context
                                        .read<ReviewSessionCubit>()
                                        .updateCardReviewStatus(
                                          cardId: dueCards[currentCardIndex].id,
                                          isCorrect: true,
                                        );
                                    context.read<CardCubit>().getCardList();
                                    setState(() {
                                      currentCardIndex++;
                                      showFullCard = false;
                                    });
                                  },
                                  child: Text(
                                    'Correct',
                                    style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                    ),
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
