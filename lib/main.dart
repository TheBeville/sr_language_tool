import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sr_language_tool/locator.dart';
import 'package:sr_language_tool/pages/home_view.dart';
import 'package:sr_language_tool/services/card_cubit.dart';
import 'package:sr_language_tool/services/review_session_cubit.dart';
import 'package:sr_language_tool/theme.dart';
import 'package:sr_language_tool/services/database_service.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

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
    return MultiBlocProvider(
      providers: [
        BlocProvider<CardCubit>(
          create: (context) => CardCubit(),
        ),
        BlocProvider<ReviewSessionCubit>(
          create: (context) => ReviewSessionCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorObservers: [routeObserver],
        theme: darkTheme,
        home: const HomeView(),
      ),
    );
  }
}
