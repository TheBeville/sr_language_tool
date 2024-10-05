import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sr_language_tool/constants.dart';
import 'package:sr_language_tool/locator.dart';
import 'package:sr_language_tool/models/database.dart' as database_model;
import 'package:sr_language_tool/pages/create_card_page.dart';
import 'package:sr_language_tool/pages/review_card_page.dart';
import 'package:sr_language_tool/pages/view_card_page.dart';
import 'package:sr_language_tool/services/card_cubit.dart';
import 'package:sr_language_tool/services/database_service.dart';
import 'package:sr_language_tool/widgets/lang_overview_modify_card_dialog.dart';

class LanguageOverviewPage extends StatefulWidget {
  const LanguageOverviewPage({required this.selectedLanguage, super.key});

  final String selectedLanguage;

  @override
  State<LanguageOverviewPage> createState() => _LanguageOverviewPageState();
}

class _LanguageOverviewPageState extends State<LanguageOverviewPage> {
  final dB = locator.get<database_model.AppDatabase>();
  final dBService = locator.get<DatabaseService>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.selectedLanguage.toUpperCase(),
            style: appBarTitleStyling,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReviewCardPage(
                        selectedLanguage: widget.selectedLanguage,
                      ),
                    ),
                  );
                },
                child: const Text(
                  'Review',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: BlocBuilder<CardCubit, List<database_model.Card>>(
          builder: (context, cards) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: ListView.builder(
                itemCount: cards.length,
                itemBuilder: (context, index) {
                  final card = cards[index];

                  return Column(
                    children: [
                      ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              card.frontContent,
                              style: const TextStyle(fontSize: 18),
                            ),
                            Text(
                              'Due: ${card.nextReviewDue.day}/${card.nextReviewDue.month}/${card.nextReviewDue.year}',
                              style: TextStyle(
                                color: (card.lastReview
                                            .isAfter(card.nextReviewDue) ||
                                        card.lastReview.isAtSameMomentAs(
                                          card.nextReviewDue,
                                        ))
                                    ? Colors.red
                                    : Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        minVerticalPadding: 0,
                        horizontalTitleGap: 0,
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 0),
                        minTileHeight: 30,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ViewCardPage(
                                cardLanguage: widget.selectedLanguage,
                                card: card,
                              ),
                            ),
                          );
                        },
                        onLongPress: () {
                          showDialog(
                            context: context,
                            builder: (context) => ModifyCardDialog(card: card),
                          );
                        },
                      ),
                      const Divider(height: 1),
                    ],
                  );
                },
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Theme.of(context).primaryColorLight,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    CreateCardPage(defaultLanguage: widget.selectedLanguage),
              ),
            );
          },
        ),
      ),
    );
  }
}
