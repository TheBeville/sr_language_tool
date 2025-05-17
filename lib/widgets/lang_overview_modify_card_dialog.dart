import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sr_language_tool/locator.dart';
import 'package:sr_language_tool/models/database.dart' as database_model;
import 'package:sr_language_tool/pages/create_card_page.dart';
import 'package:sr_language_tool/services/card_cubit.dart';
import 'package:sr_language_tool/services/database_service.dart';

class ModifyCardDialog extends StatefulWidget {
  const ModifyCardDialog({required this.card, super.key});

  final database_model.Card card;

  @override
  State<ModifyCardDialog> createState() => _ModifyCardDialogState();
}

class _ModifyCardDialogState extends State<ModifyCardDialog> {
  final dBService = locator.get<DatabaseService>();
  String? language;

  @override
  void initState() {
    super.initState();
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    final lang = await dBService.getLangByID(widget.card.language);
    if (mounted) {
      setState(() {
        language = lang;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardCubit, List<database_model.Card>>(
      builder: (context, cards) {
        return AlertDialog(
          title: const Text('Modify card?'),
          actions: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    onPressed: () async {
                      if (context.mounted) {
                        Navigator.of(context).pop();
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateCardPage(
                              appBarTitle: 'Edit Card',
                              card: widget.card,
                              defaultLanguage: language!,
                            ),
                          ),
                        );
                      }
                    },
                    child: const Text('Edit'),
                  ),
                  MaterialButton(
                    onPressed: () async {
                      if (context.mounted) {
                        await context
                            .read<CardCubit>()
                            .deleteCard(widget.card.id, language!);
                        if (context.mounted) Navigator.of(context).pop();
                      }
                    },
                    child: const Text('Delete'),
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
        );
      },
    );
  }
}
