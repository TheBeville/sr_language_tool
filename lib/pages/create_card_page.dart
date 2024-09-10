import 'package:flutter/material.dart';
import 'package:sr_language_tool/locator.dart';
import 'package:sr_language_tool/models/database.dart' as database_model;
import 'package:sr_language_tool/models/database.dart';
import 'package:sr_language_tool/services/database_service.dart';

class CreateCardPage extends StatelessWidget {
  CreateCardPage({this.defaultLanguage, super.key});

  final String? defaultLanguage;

  final database = locator.get<database_model.AppDatabase>();
  final dBService = locator.get<DatabaseService>();

  final TextEditingController languageController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController frontContentController = TextEditingController();
  final TextEditingController revealContentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // final Future<List<Language>> allLanguages = dBService.getAllLanguages();

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

              // Dropdown for language selection
              FutureBuilder<List<database_model.Language>>(
                future: dBService.getAllLanguages(),
                builder: (context, snapshot) {
                  final List<database_model.Language>? languages =
                      snapshot.data;

                  if (snapshot.data == null) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done) {
                    return DropdownMenu(
                      controller: languageController,
                      label: const Text('Language'),
                      width: 342,
                      initialSelection: defaultLanguage ?? 1,
                      menuStyle: MenuStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(Colors.grey.shade800),
                      ),
                      dropdownMenuEntries: languages!.map((l) {
                        return DropdownMenuEntry(
                          value: l.language,
                          label: l.language,
                        );
                      }).toList(),
                    );
                  } else {
                    return const Text('Loading...');
                  }
                },
              ),
              const SizedBox(height: 20),

              // Dropdown for word category selection
              FutureBuilder<List<database_model.Category>>(
                future: dBService.getAllCategories(),
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done) {
                    final List<database_model.Category> categories =
                        snapshot.data!;

                    return DropdownMenu(
                      controller: categoryController,
                      label: const Text('Word Class/Category'),
                      width: 342,
                      menuStyle: MenuStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(Colors.grey.shade800),
                      ),
                      dropdownMenuEntries: categories.map((c) {
                        return DropdownMenuEntry(
                          value: c.category,
                          label: c.category,
                        );
                      }).toList(),
                    );
                  } else {
                    return const Text('Loading...');
                  }
                },
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
