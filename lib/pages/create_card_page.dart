import 'package:flutter/material.dart';
import 'package:sr_language_tool/locator.dart';
import 'package:sr_language_tool/models/database.dart' as database_model;
import 'package:sr_language_tool/models/database.dart';
import 'package:sr_language_tool/services/database_service.dart';

class CreateCardPage extends StatelessWidget {
  CreateCardPage({super.key});

  final database = locator.get<database_model.AppDatabase>();
  final dBService = locator.get<DatabaseService>();

  final TextEditingController languageController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController frontContentController = TextEditingController();
  final TextEditingController revealContentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Future<List<Language>> allLanguages = dBService.getAllLanguages();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'CREATE CARD',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              const SizedBox(height: 35),
              // TODO: fix this
              DropdownMenu(
                controller: languageController,
                label: const Text('Language'),
                width: 342,
                dropdownMenuEntries: const [
                  DropdownMenuEntry(
                    value: 'German',
                    label: 'German',
                  ),
                ],
              ),
              const SizedBox(height: 20),
              DropdownMenu(
                controller: languageController,
                label: const Text('Word Class/Category'),
                width: 342,
                dropdownMenuEntries: const [
                  DropdownMenuEntry(
                    value: 'Example Word Category',
                    label: 'Example Word Class/Category',
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Front Content',
                  hintText: 'Enter text for front of card...',
                ),
                controller: frontContentController,
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Reveal Content',
                  hintText: 'Enter text to be revealed...',
                ),
                controller: revealContentController,
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.grey.shade200),
                ),
                onPressed: () {
                  dBService.createCard(
                    languageController.text,
                    categoryController.text,
                    frontContentController.text,
                    revealContentController.text,
                  );
                },
                child: Text(
                  'Create',
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
