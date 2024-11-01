import 'package:flutter/material.dart';
import 'package:sr_language_tool/constants.dart';
import 'package:sr_language_tool/locator.dart';
import 'package:sr_language_tool/models/database.dart' as database_model;
import 'package:sr_language_tool/services/database_service.dart';
import 'package:sr_language_tool/widgets/viewable_card.dart';

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
          centerTitle: true,
        ),
        body: ViewableCard(card: card),
      ),
    );
  }
}
