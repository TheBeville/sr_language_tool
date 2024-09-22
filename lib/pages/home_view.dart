import 'package:flutter/material.dart';
import 'package:sr_language_tool/constants.dart';
import 'package:sr_language_tool/locator.dart';
import 'package:sr_language_tool/models/database.dart' as database_model;
import 'package:sr_language_tool/pages/create_card_page.dart';
import 'package:sr_language_tool/pages/language_overview_page.dart';
import 'package:sr_language_tool/services/database_service.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final dB = locator.get<database_model.AppDatabase>();
  final dBService = locator.get<DatabaseService>();
  final addLangController = TextEditingController();

  @override
  void dispose() {
    addLangController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'SR TOOL',
            style: appBarTitleStyling,
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
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: FutureBuilder<List<database_model.Language>>(
                future: dBService.getAllLanguages(),
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        final String selectedLanguage =
                            snapshot.data![index].language;
                        return ListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20),
                          minVerticalPadding: 0,
                          minTileHeight: 35,
                          // leading: const Icon(Icons.flag),
                          title: Text(
                            snapshot.data![index].language,
                            style: const TextStyle(fontSize: 20),
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
                          onLongPress: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Delete language?'),
                                actions: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      MaterialButton(
                                        child: const Text('Delete'),
                                        onPressed: () async {
                                          final int? langID = await dBService
                                              .getLangID(selectedLanguage);
                                          final int langIDOrDefault =
                                              langID ?? 1;
                                          setState(() {
                                            dBService
                                                .deleteLang(langIDOrDefault);
                                          });
                                          if (context.mounted) {
                                            Navigator.of(context).pop();
                                          }
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          MaterialButton(
                            child: const Text('Add'),
                            onPressed: () {
                              setState(() {
                                dBService.createLangCat(addLangController.text);
                              });
                              Navigator.of(context).pop();
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
            MaterialButton(
              onPressed: dBService.clearData,
              child: const Text('Reset/Erase DB'),
            ),
            const Spacer(flex: 1),
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
                builder: (context) => const CreateCardPage(),
              ),
            );
          },
        ),
      ),
    );
  }
}
