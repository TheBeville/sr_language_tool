import 'package:flutter/material.dart';
import 'package:sr_language_tool/constants.dart';
import 'package:sr_language_tool/locator.dart';
import 'package:sr_language_tool/models/database.dart' as database_model;
import 'package:sr_language_tool/services/database_service.dart';

class ViewableCard extends StatefulWidget {
  const ViewableCard({
    required this.card,
    super.key,
  });

  final database_model.Card card;

  @override
  State<ViewableCard> createState() => _ViewableCardState();
}

class _ViewableCardState extends State<ViewableCard> {
  final dBService = locator.get<DatabaseService>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.card.frontContent,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            width: 342,
            child: Divider(
              height: 10,
              thickness: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Row(
              children: [
                FutureBuilder<String?>(
                  future: dBService.getCatByID(widget.card.category),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData || snapshot.data == null) {
                      return const Text('Cat. not found');
                    } else {
                      return Text(
                        '[${snapshot.data!}]',
                        style: cardInfoStyling,
                      );
                    }
                  },
                ),
                const SizedBox(width: 2),
                widget.card.gender == ''
                    ? const SizedBox()
                    : Text(
                        '[${widget.card.gender}]',
                        style: cardInfoStyling,
                      ),
                const SizedBox(width: 2),
              ],
            ),
          ),
          const SizedBox(height: 15),
          Text(
            widget.card.revealContent,
            style: const TextStyle(fontSize: 30),
          ),
          widget.card.pluralForm == null
              ? const SizedBox()
              : Column(
                  children: [
                    Text(
                      '(plural: ${widget.card.pluralForm})',
                      style: cardInfoStyling,
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
          widget.card.pronunciation == null
              ? const SizedBox()
              : Column(
                  children: [
                    Text(
                      'Pronunciation: ${widget.card.pronunciation}',
                      style: cardInfoStyling,
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
          widget.card.exampleUsage == null
              ? const SizedBox()
              : Column(
                  children: [
                    Text(
                      'Example: ${widget.card.exampleUsage}',
                      style: cardInfoStyling,
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
        ],
      ),
    );
  }
}
