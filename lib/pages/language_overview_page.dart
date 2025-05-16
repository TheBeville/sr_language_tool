import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sr_language_tool/constants.dart';
import 'package:sr_language_tool/models/database.dart' as database_model;
import 'package:sr_language_tool/pages/create_card_page.dart';
import 'package:sr_language_tool/pages/review_card_page.dart';
import 'package:sr_language_tool/pages/view_card_page.dart';
import 'package:sr_language_tool/services/card_cubit.dart';
import 'package:sr_language_tool/services/review_session_cubit.dart';
import 'package:sr_language_tool/widgets/lang_overview_modify_card_dialog.dart';

class LanguageOverviewPage extends StatefulWidget {
  const LanguageOverviewPage({required this.selectedLanguage, super.key});

  final String selectedLanguage;

  @override
  State<LanguageOverviewPage> createState() => _LanguageOverviewPageState();
}

class _LanguageOverviewPageState extends State<LanguageOverviewPage> {
  @override
  void initState() {
    super.initState();
    context.read<CardCubit>().getCardsOfLang(widget.selectedLanguage);
    context
        .read<ReviewSessionCubit>()
        .getDueCardsOfLang(widget.selectedLanguage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<CardCubit>().getCardsOfLang(widget.selectedLanguage);
    context
        .read<ReviewSessionCubit>()
        .getDueCardsOfLang(widget.selectedLanguage);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.selectedLanguage.toUpperCase(),
            style: appBarTitleStyling,
          ),
          centerTitle: true,
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
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
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
            ),
          ],
        ),
        body: BlocBuilder<CardCubit, List<database_model.Card>>(
          builder: (context, cards) {
            final sortedCards = cards.sorted(
              (a, b) => a.frontContent
                  .toLowerCase()
                  .compareTo(b.frontContent.toLowerCase()),
            );

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: ListView.builder(
                itemCount: sortedCards.length,
                itemBuilder: (context, index) {
                  final card = sortedCards[index];
                  final bool isDue =
                      card.nextReviewDue.isBefore(DateTime.now()) ||
                          card.nextReviewDue.isAtSameMomentAs(DateTime.now());
                  final String cardName = card.frontContent.length > 20
                      ? '${card.frontContent.substring(0, 20)}...'
                      : card.frontContent;

                  return Column(
                    children: [
                      ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              cardName,
                              style: const TextStyle(fontSize: 18),
                            ),
                            Text(
                              isDue
                                  ? 'Due Now'
                                  : 'Due: ${card.nextReviewDue.day}/${card.nextReviewDue.month}/${card.nextReviewDue.year}',
                              style: TextStyle(
                                color: isDue ? Colors.red : Colors.white,
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
                            builder: (_) => ModifyCardDialog(card: card),
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
                builder: (context) => CreateCardPage(
                  appBarTitle: 'Create Card',
                  defaultLanguage: widget.selectedLanguage,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
