import 'package:flutter/material.dart';
import 'package:sr_language_tool/locator.dart';
import 'package:sr_language_tool/pages/home_view.dart';
import 'package:sr_language_tool/theme.dart';
import 'package:sr_language_tool/services/database_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  DatabaseService().initialiseDB();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: darkTheme,
      home: HomeView(),
    );
  }
}
