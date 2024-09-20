import 'package:flutter/material.dart';
import 'package:sr_language_tool/locator.dart';
import 'package:sr_language_tool/models/database.dart' as database_model;
import 'package:sr_language_tool/services/database_service.dart';
// import 'package:sr_language_tool/widgets/reviewable_card.dart';

class ReviewCardPage extends StatelessWidget {
  ReviewCardPage({required this.selectedLanguage, super.key});
  final String selectedLanguage;

  final dB = locator.get<database_model.AppDatabase>();
  final dBService = locator.get<DatabaseService>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Reviewing: $selectedLanguage'),
        ),
        // TODO: sort so a card can be passed in
        // body: ReviewableCard(dBCard: , userHasTapped: false),
      ),
    );
  }
}
