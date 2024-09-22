import 'package:flutter/material.dart';
import 'package:sr_language_tool/constants.dart';
import 'package:sr_language_tool/locator.dart';
import 'package:sr_language_tool/models/database.dart' as database_model;
import 'package:sr_language_tool/services/database_service.dart';

class ViewCardPage extends StatelessWidget {
  ViewCardPage({
    required this.cardLanguage,
    required this.card,
    super.key,
  });

  final database_model.Card card;
  final String cardLanguage;

  final dbService = locator.get<DatabaseService>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            cardLanguage.toUpperCase(),
            style: appBarTitleStyling,
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Text(
              card.frontContent,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              width: 342,
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
                    future: dbService.getCatByID(card.category),
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
                  card.gender == null
                      ? const SizedBox()
                      : Text(
                          '[${card.gender}]',
                          style: cardInfoStyling,
                        ),
                  const SizedBox(width: 2),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Text(
              card.revealContent,
              style: const TextStyle(fontSize: 28),
            ),
            card.pluralForm == null
                ? const SizedBox(height: 30)
                : Column(
                    children: [
                      Text(
                        '(plural: ${card.pluralForm})',
                        style: cardInfoStyling,
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
            const Spacer(),
            Text(
              'Last reviewed: ${card.lastReview}',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
