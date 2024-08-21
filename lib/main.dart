import 'package:flutter/material.dart';
import 'package:sr_language_tool/models/database.dart';
import 'package:sr_language_tool/pages/home_view.dart';
import 'package:sr_language_tool/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = AppDatabase();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: darkTheme,
      home: const HomeView(),
    );
  }
}
