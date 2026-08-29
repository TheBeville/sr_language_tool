import 'package:flutter/material.dart';
import 'package:sr_language_tool/locator.dart';
import 'package:sr_language_tool/models/database.dart' as database_model;
import 'package:sr_language_tool/services/database_service.dart';

class AddEditLanguageDialog extends StatefulWidget {
  const AddEditLanguageDialog({this.language, super.key});

  // null = create mode, non-null = edit mode
  final database_model.Language? language;

  @override
  State<AddEditLanguageDialog> createState() => _AddEditLanguageDialogState();
}

class _AddEditLanguageDialogState extends State<AddEditLanguageDialog> {
  final _dBService = locator.get<DatabaseService>();
  late final TextEditingController _nameController;
  final List<TextEditingController> _genderControllers = [];

  bool get _isEditing => widget.language != null;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.language?.language ?? '',
    );
    if (_isEditing) _loadGenders();
  }

  Future<void> _loadGenders() async {
    final genders = await _dBService.getGendersOfLang(
      widget.language!.language,
    );
    if (mounted) {
      setState(() {
        for (final g in genders) {
          _genderControllers.add(TextEditingController(text: g.gender));
        }
      });
    }
  }

  void _addGenderField() {
    setState(() => _genderControllers.add(TextEditingController()));
  }

  void _removeGenderField(int index) {
    setState(() {
      _genderControllers[index].dispose();
      _genderControllers.removeAt(index);
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    for (final c in _genderControllers) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _save() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;

    final genders = _genderControllers
        .map((c) => c.text.trim())
        .where((s) => s.isNotEmpty)
        .toList();

    if (_isEditing) {
      if (name != widget.language!.language) {
        await _dBService.updateLangName(widget.language!.id, name);
      }
      await _dBService.replaceGendersForLang(widget.language!.id, genders);
    } else {
      await _dBService.createLangCat(name);
      for (final gender in genders) {
        await _dBService.createGender(name, gender);
      }
    }

    if (mounted) Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_isEditing ? 'Edit Language' : 'Add Language'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Language Name'),
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 16),
            if (_genderControllers.isNotEmpty) ...[
              const Text(
                'Genders',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 4),
            ],
            for (int i = 0; i < _genderControllers.length; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _genderControllers[i],
                        decoration: InputDecoration(
                          labelText: 'Gender ${i + 1}',
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline, size: 20),
                      onPressed: () => _removeGenderField(i),
                    ),
                  ],
                ),
              ),
            TextButton.icon(
              onPressed: _addGenderField,
              icon: const Icon(Icons.add, size: 16),
              label: const Text('Add gender'),
            ),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MaterialButton(
              onPressed: _save,
              child: Text(_isEditing ? 'Save' : 'Add'),
            ),
            MaterialButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
          ],
        ),
      ],
    );
  }
}
