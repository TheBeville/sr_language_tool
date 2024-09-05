import 'package:flutter/material.dart';
import 'package:sr_language_tool/locator.dart';
import 'package:sr_language_tool/models/database.dart' as database_model;
import 'package:sr_language_tool/services/database_service.dart';

class LanguageOverviewPage extends StatelessWidget {
  LanguageOverviewPage({required this.selectedLanguage, super.key});

  final database = locator.get<database_model.AppDatabase>();
  final databaseService = locator.get<DatabaseService>();

  final String selectedLanguage;

  final List<Card> langCards = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            selectedLanguage,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        body: const Column(
          children: [],
        ),
      ),
    );
  }
}
