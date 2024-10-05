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
  final dB = locator.get<database_model.AppDatabase>();
  final dBService = locator.get<DatabaseService>();
  final cardCubit = locator.get<CardCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CardCubit, List<database_model.Card>>(
      builder: (context, cards) {
        return AlertDialog(
          title: const Text('Modify card?'),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  child: const Text('Edit'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CreateCardPage(),
                      ),
                    );
                  },
                ),
                MaterialButton(
                  child: const Text('Delete'),
                  onPressed: () {
                    context.read<CardCubit>().deleteCard(widget.card.id);
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
        );
      },
    );
  }
}
