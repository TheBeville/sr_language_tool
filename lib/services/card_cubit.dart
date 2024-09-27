import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sr_language_tool/locator.dart';
import 'package:sr_language_tool/models/database.dart' as database_model;
import 'package:sr_language_tool/services/database_service.dart';

class CardCubit extends Cubit<List<database_model.Card>> {
  CardCubit() : super([]) {
    getCardList();
  }

  final dB = locator.get<database_model.AppDatabase>();
  final dBService = locator.get<DatabaseService>();

  Future<void> getCardList() async {
    final cardList = await dBService.getAllCards();

    emit(cardList);
  }
}
