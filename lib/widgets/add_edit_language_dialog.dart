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
  late final TextEditingController _newGenderController;

  List<database_model.Gender> _allGenders = [];
  final Set<int> _selectedGenderIds = {};
  bool _isLoading = true;

  bool get _isEditing => widget.language != null;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.language?.language ?? '',
    );
    _newGenderController = TextEditingController();
    _loadData();
  }

  Future<void> _loadData() async {
    final allGenders = await _dBService.getAllGenders();
    final selectedIds = <int>{};
    if (_isEditing) {
      final currentGenders = await _dBService.getGendersOfLangId(
        widget.language!.id,
      );
      selectedIds.addAll(currentGenders.map((g) => g.id));
    }
    if (mounted) {
      setState(() {
        _allGenders = allGenders;
        _selectedGenderIds.addAll(selectedIds);
        _isLoading = false;
      });
    }
  }

  Future<void> _addNewGender() async {
    final text = _newGenderController.text.trim();
    if (text.isEmpty) return;

    final existingIndex = _allGenders.indexWhere(
      (g) => g.gender.toLowerCase() == text.toLowerCase(),
    );

    if (existingIndex != -1) {
      setState(() {
        _selectedGenderIds.add(_allGenders[existingIndex].id);
        _newGenderController.clear();
      });
    } else {
      final created = await _dBService.getOrCreateGender(text);
      if (mounted) {
        setState(() {
          _allGenders.add(created);
          _selectedGenderIds.add(created.id);
          _newGenderController.clear();
        });
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _newGenderController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;

    // If user typed a new gender into the field but didn't tap add, include it
    final pendingGender = _newGenderController.text.trim();
    if (pendingGender.isNotEmpty) {
      final created = await _dBService.getOrCreateGender(pendingGender);
      _selectedGenderIds.add(created.id);
    }

    if (_isEditing) {
      if (name != widget.language!.language) {
        await _dBService.updateLangName(widget.language!.id, name);
      }
      await _dBService.setGendersForLang(
        widget.language!.id,
        _selectedGenderIds,
      );
    } else {
      await _dBService.createLangCat(name);
      final langId = await _dBService.getLangID(name);
      await _dBService.setGendersForLang(
        langId,
        _selectedGenderIds,
      );
    }

    if (mounted) Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_isEditing ? 'Edit Language' : 'Add Language'),
      content: _isLoading
          ? const SizedBox(
              height: 100,
              child: Center(child: CircularProgressIndicator()),
            )
          : SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _nameController,
                    decoration:
                        const InputDecoration(labelText: 'Language Name'),
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Available Genders',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (_allGenders.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        'No genders created yet. Add one below.',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    )
                  else
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 4.0,
                      children: _allGenders.map((g) {
                        final isSelected = _selectedGenderIds.contains(g.id);
                        return FilterChip(
                          label: Text(g.gender),
                          selected: isSelected,
                          onSelected: (selected) {
                            setState(() {
                              if (selected) {
                                _selectedGenderIds.add(g.id);
                              } else {
                                _selectedGenderIds.remove(g.id);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _newGenderController,
                          decoration: const InputDecoration(
                            labelText: 'Add new gender',
                            hintText: 'e.g. Masculine',
                            isDense: true,
                          ),
                          textInputAction: TextInputAction.done,
                          onSubmitted: (_) => _addNewGender(),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline),
                        tooltip: 'Add gender',
                        onPressed: _addNewGender,
                      ),
                    ],
                  ),
                ],
              ),
            ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MaterialButton(
              onPressed: _isLoading ? null : _save,
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
