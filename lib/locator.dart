import 'package:get_it/get_it.dart';
import 'package:sr_language_tool/models/database.dart';
import 'package:sr_language_tool/services/card_cubit.dart';
import 'package:sr_language_tool/services/database_service.dart';
import 'package:sr_language_tool/services/review_session_cubit.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<AppDatabase>(() => AppDatabase());
  locator.registerLazySingleton<DatabaseService>(() => DatabaseService());
  locator.registerLazySingleton<CardCubit>(() => CardCubit());
  locator.registerLazySingleton<ReviewSessionCubit>(() => ReviewSessionCubit());
}
