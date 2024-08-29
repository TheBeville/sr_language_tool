import 'package:get_it/get_it.dart';
import 'package:sr_language_tool/models/database.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<AppDatabase>(() => AppDatabase());
}
