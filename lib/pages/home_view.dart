import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sr_language_tool/constants.dart';
import 'package:sr_language_tool/locator.dart';
import 'package:sr_language_tool/main.dart';
import 'package:sr_language_tool/models/database.dart' as database_model;
import 'package:sr_language_tool/pages/create_card_page.dart';
import 'package:sr_language_tool/pages/language_overview_page.dart';
import 'package:sr_language_tool/pages/settings_page.dart';
import 'package:sr_language_tool/widgets/add_edit_language_dialog.dart';
import 'package:sr_language_tool/services/auth_cubit.dart';
import 'package:sr_language_tool/services/database_service.dart';
import 'package:sr_language_tool/services/review_session_cubit.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with RouteAware {
  final dBService = locator.get<DatabaseService>();

  @override
  void initState() {
    super.initState();
    context.read<ReviewSessionCubit>().getDueCards();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(
      this,
      ModalRoute.of(context)! as PageRoute<dynamic>,
    );
    context.read<ReviewSessionCubit>().getDueCards();
  }

  @override
  void didPopNext() {
    context.read<ReviewSessionCubit>().getDueCards();
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
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
          centerTitle: true,
          leading: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is! AuthAuthenticated) return const SizedBox.shrink();
              return Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: IconButton(
                  icon: const Icon(Icons.cloud_upload),
                  iconSize: 32.0,
                  onPressed: () {},
                ),
              );
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: IconButton(
                icon: const Icon(Icons.settings),
                iconSize: 32.0,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingsPage(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
        body: BlocBuilder<ReviewSessionCubit, List<database_model.Card>>(
          builder: (context, cards) {
            return Column(
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
                Flexible(
                  child: FutureBuilder<List<database_model.Language>>(
                    future: dBService.getAllLanguages(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData &&
                          snapshot.connectionState == ConnectionState.done) {
                        return ListView.builder(
                          itemCount: snapshot.data!.length + 1,
                          itemBuilder: (context, index) {
                            if (index < snapshot.data!.length) {
                              final String selectedLanguage =
                                  snapshot.data![index].language;
                              final int selectedLangID =
                                  snapshot.data![index].id;
                              final int numDue = cards
                                  .where((l) => l.language == selectedLangID)
                                  .toList()
                                  .length;

                              return ListTile(
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                minVerticalPadding: 0,
                                minTileHeight: 35,
                                title: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      snapshot.data![index].language,
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    Text(
                                      '$numDue Due',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          LanguageOverviewPage(
                                        selectedLanguage: selectedLanguage,
                                      ),
                                    ),
                                  );
                                },
                                onLongPress: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text(
                                        selectedLanguage,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      actions: [
                                        FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              MaterialButton(
                                                child: const Text('Edit'),
                                                onPressed: () async {
                                                  Navigator.of(context).pop();
                                                  final result =
                                                      await showDialog<bool>(
                                                    context: context,
                                                    builder: (context) =>
                                                        AddEditLanguageDialog(
                                                      language:
                                                          snapshot.data![index],
                                                    ),
                                                  );
                                                  if (result == true) {
                                                    setState(() {});
                                                  }
                                                },
                                              ),
                                              MaterialButton(
                                                child: const Text('Delete'),
                                                onPressed: () async {
                                                  setState(() {
                                                    dBService.deleteLang(
                                                      selectedLangID,
                                                    );
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
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            } else {
                              return ListTile(
                                leading: const Icon(Icons.add),
                                title: const Text('Add Language'),
                                onTap: () async {
                                  final result = await showDialog<bool>(
                                    context: context,
                                    builder: (context) =>
                                        const AddEditLanguageDialog(),
                                  );
                                  if (result == true) setState(() {});
                                },
                              );
                            }
                          },
                        );
                      } else {
                        return const Text('Loading...');
                      }
                    },
                  ),
                ),
                // ONLY USE IF NECESSARY, WIPES ALL DATA
                // MaterialButton(
                //   onPressed: dBService.clearData,
                //   child: const Text('Reset/Erase DB'),
                // ),

                const Spacer(flex: 1),
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(
              color: Colors.white,
              width: 1,
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    const CreateCardPage(appBarTitle: 'Create Card'),
              ),
            );
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
