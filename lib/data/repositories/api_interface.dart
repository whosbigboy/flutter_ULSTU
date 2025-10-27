import 'package:flutter_app/domain/models/card.dart';

abstract class ApiInterface {
  Future<List<CardData>?> loadData({String? q});
}
