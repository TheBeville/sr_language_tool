import 'package:flutter/material.dart';
import 'package:sr_language_tool/locator.dart';
import 'package:sr_language_tool/models/database.dart' as database_model;
import 'package:sr_language_tool/pages/create_card_page.dart';
import 'package:sr_language_tool/pages/language_overview_page.dart';
import 'package:sr_language_tool/services/database_service.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final database = locator.get<database_model.AppDatabase>();
  final dbService = locator.get<DatabaseService>();
  final addLangController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'SR TOOL',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        body: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                child: Text(
                  'Languages',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: FutureBuilder<List<database_model.Language>>(
                future: dbService.getAllLanguages(),
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final String selectedLanguage =
                            snapshot.data![index].language;
                        return ListTile(
                          leading: const Icon(Icons.flag),
                          title: Text(
                            snapshot.data![index].language,
                            style: const TextStyle(fontSize: 18),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LanguageOverviewPage(
                                  selectedLanguage: selectedLanguage,
                                ),
                              ),
                            );
                          },
                        );
                      },
                      itemCount: snapshot.data!.length,
                    );
                  } else {
                    return const Text('Loading...');
                  }
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Add Language'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: TextField(
                      controller: addLangController,
                      decoration: const InputDecoration(
                        labelText: 'Language Name',
                      ),
                    ),
                    actions: [
                      MaterialButton(
                        child: const Text('Add'),
                        onPressed: () {
                          dbService.createLangCat(addLangController.text);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
            MaterialButton(
                child: const Text('Del. Card'),
                onPressed: () {
                  dbService.deleteCard(1);
                }),
            const Spacer(flex: 2),
          ],
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
                builder: (context) => CreateCardPage(),
              ),
            );
          },
        ),
      ),
    );
  }
}
