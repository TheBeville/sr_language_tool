import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sr_language_tool/constants.dart';
import 'package:sr_language_tool/locator.dart';
import 'package:sr_language_tool/models/database.dart' as database_model;
import 'package:sr_language_tool/services/card_cubit.dart';
import 'package:sr_language_tool/services/database_service.dart';

class CreateCardPage extends StatefulWidget {
  const CreateCardPage({
    required this.appBarTitle,
    this.defaultLanguage,
    this.card,
    super.key,
  });

  final String? defaultLanguage;
  final String appBarTitle;
  final database_model.Card? card;

  @override
  State<CreateCardPage> createState() => _CreateCardPageState();
}

class _CreateCardPageState extends State<CreateCardPage> {
  final dBService = locator.get<DatabaseService>();

  final TextEditingController languageController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController frontContentController = TextEditingController();
  final TextEditingController revealContentController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController pluralController = TextEditingController();
  final TextEditingController pronunciationController = TextEditingController();
  final TextEditingController exampleUsageController = TextEditingController();

  bool isNoun = false;

  @override
  void initState() {
    super.initState();

    // Initialize controllers with values from the provided card, if any
    if (widget.card != null) {
      final card = widget.card!;
      languageController.text = widget.defaultLanguage ?? '';
      dBService.getCatByID(card.category).then((category) {
        categoryController.text = category ?? '';
      });
      frontContentController.text = card.frontContent;
      revealContentController.text = card.revealContent;
      genderController.text = card.gender ?? '';
      pluralController.text = card.pluralForm ?? '';
      pronunciationController.text = card.pronunciation ?? '';
      exampleUsageController.text = card.exampleUsage ?? '';

      // Set isNoun based on the category
      dBService.getCatByID(card.category).then((category) {
        if (category == 'Noun') {
          setState(() {
            isNoun = true;
          });
        }
      });
    } else if (widget.defaultLanguage != null) {
      languageController.text = widget.defaultLanguage!;
    }
  }

  @override
  void dispose() {
    languageController.dispose();
    categoryController.dispose();
    frontContentController.dispose();
    revealContentController.dispose();
    genderController.dispose();
    pluralController.dispose();
    pronunciationController.dispose();
    exampleUsageController.dispose();
    super.dispose();
  }

  void clearControllers() {
    categoryController.clear();
    frontContentController.clear();
    revealContentController.clear();
    genderController.clear();
    pluralController.clear();
    pronunciationController.clear();
    exampleUsageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final String appBarTitle = widget.appBarTitle;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            appBarTitle,
            style: appBarTitleStyling,
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<CardCubit, List<database_model.Card>>(
          builder: (context, cards) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),

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
                            initialSelection: widget.defaultLanguage ?? 1,
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
                            initialSelection: widget.card?.category ?? 1,
                            menuStyle: MenuStyle(
                              backgroundColor:
                                  WidgetStatePropertyAll(Colors.grey.shade800),
                            ),
                            onSelected: (value) {
                              setState(() {
                                if (value == 'Noun') {
                                  isNoun = true;
                                } else {
                                  isNoun = false;
                                }
                              });
                            },
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
                    // Adds dropdown to select noun gender if category == noun
                    isNoun
                        ? Column(
                            children: [
                              const SizedBox(height: 20),
                              DropdownMenu(
                                controller: genderController,
                                width: 342,
                                label: const Text('Gender'),
                                initialSelection: widget.card?.gender ?? 1,
                                dropdownMenuEntries: const [
                                  DropdownMenuEntry(
                                    value: 'Masc.',
                                    label: 'Masc.',
                                  ),
                                  DropdownMenuEntry(
                                    value: 'Fem.',
                                    label: 'Fem.',
                                  ),
                                  DropdownMenuEntry(
                                    value: 'Neut.',
                                    label: 'Neut.',
                                  ),
                                ],
                              ),
                            ],
                          )
                        : const SizedBox(),
                    const SizedBox(height: createCardTextFieldSpace),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Front Content',
                        hintText: 'Enter text for front of card...',
                      ),
                      controller: frontContentController,
                    ),
                    const SizedBox(height: createCardTextFieldSpace),
                    TextField(
                      decoration: const InputDecoration(
                        labelText: 'Reveal Content',
                        hintText: 'Enter text to be revealed...',
                      ),
                      controller: revealContentController,
                    ),
                    // Adds field for plural form if category = noun
                    isNoun
                        ? Column(
                            children: [
                              const SizedBox(height: createCardTextFieldSpace),
                              TextField(
                                controller: pluralController,
                                decoration: const InputDecoration(
                                  labelText: 'Plural Form (Optional)',
                                  hintText: 'Enter the plural form of the noun',
                                ),
                              ),
                            ],
                          )
                        : const SizedBox(),
                    const SizedBox(height: createCardTextFieldSpace),
                    TextField(
                      controller: pronunciationController,
                      decoration: const InputDecoration(
                        labelText: 'Pronunciation (Optional)',
                        hintText: 'Add pronunciation guideline',
                      ),
                    ),
                    const SizedBox(height: createCardTextFieldSpace),
                    TextField(
                      controller: exampleUsageController,
                      decoration: const InputDecoration(
                        labelText: 'Example Usage (Optional)',
                        hintText: 'Enter an example of usage',
                      ),
                    ),
                    const SizedBox(height: 50),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(Colors.grey.shade200),
                      ),
                      onPressed: () async {
                        final bool cardCreated;
                        widget.card == null
                            ? cardCreated = await context
                                .read<CardCubit>()
                                .createCard(
                                  language: languageController.text,
                                  category: categoryController.text,
                                  frontContent: frontContentController.text,
                                  revealContent: revealContentController.text,
                                  gender: isNoun ? genderController.text : null,
                                  pluralForm: pluralController.text.isEmpty
                                      ? null
                                      : pluralController.text,
                                  pronunciation:
                                      pronunciationController.text.isEmpty
                                          ? null
                                          : pronunciationController.text,
                                  exampleUsage:
                                      exampleUsageController.text.isEmpty
                                          ? null
                                          : exampleUsageController.text,
                                  lastReview: DateTime.now(),
                                  nextReviewDue: DateTime.now()
                                      .add(const Duration(minutes: 15)),
                                )
                            : cardCreated = await context
                                .read<CardCubit>()
                                .modifyCard(
                                  id: widget.card!.id,
                                  language: languageController.text,
                                  category: categoryController.text,
                                  frontContent: frontContentController.text,
                                  revealContent: revealContentController.text,
                                  gender: isNoun ? genderController.text : null,
                                  pluralForm: pluralController.text.isEmpty
                                      ? null
                                      : pluralController.text,
                                  pronunciation:
                                      pronunciationController.text.isEmpty
                                          ? null
                                          : pronunciationController.text,
                                  exampleUsage:
                                      exampleUsageController.text.isEmpty
                                          ? null
                                          : exampleUsageController.text,
                                  lastReview: widget.card!.lastReview,
                                  nextReviewDue: widget.card!.nextReviewDue,
                                );

                        clearControllers();
                        setState(() {
                          isNoun = false;
                        });

                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              behavior: SnackBarBehavior.floating,
                              showCloseIcon: true,
                              backgroundColor: cardCreated
                                  ? Colors.green.shade400
                                  : Colors.red.shade400,
                              content: Text(
                                (widget.appBarTitle == 'Create Card')
                                    ? (cardCreated
                                        ? 'Card added successfully'
                                        : 'Card already exists')
                                    : 'Card modified',
                              ),
                            ),
                          );
                          if (widget.card != null) Navigator.pop(context);
                        }
                      },
                      child: Text(
                        widget.card == null ? 'Create' : 'Modify',
                        style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
