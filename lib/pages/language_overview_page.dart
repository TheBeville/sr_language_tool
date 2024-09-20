import 'package:flutter/material.dart';
import 'package:sr_language_tool/constants.dart';
import 'package:sr_language_tool/locator.dart';
import 'package:sr_language_tool/models/database.dart' as database_model;
import 'package:sr_language_tool/pages/create_card_page.dart';
import 'package:sr_language_tool/pages/review_card_page.dart';
import 'package:sr_language_tool/pages/view_card_page.dart';
import 'package:sr_language_tool/services/database_service.dart';

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
        body: FutureBuilder<List<database_model.Card>>(
          future: dBService.getCardsOfLang(widget.selectedLanguage),
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.done) {
              final List<database_model.Card> cards = snapshot.data!;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: cards.map((card) {
                      return Column(
                        children: [
                          ListTile(
                            title: Text(
                              card.frontContent,
                              style: const TextStyle(fontSize: 18),
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
                                builder: (context) => AlertDialog(
                                  title: const Text('Modify card?'),
                                  actions: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        MaterialButton(
                                          child: const Text('Edit'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const CreateCardPage(),
                                              ),
                                            );
                                          },
                                        ),
                                        MaterialButton(
                                          child: const Text('Delete'),
                                          onPressed: () {
                                            setState(() {
                                              dBService.deleteCard(card.id);
                                              Navigator.of(context).pop();
                                            });
                                          },
                                        ),
                                        MaterialButton(
                                          child: const Text('Cancel'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          const Divider(height: 1),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              );
            } else {
              return const Text('Loading...');
            }
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
