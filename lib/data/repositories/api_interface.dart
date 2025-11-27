// api_interface.dart
import '../../domain/models/home.dart';

typedef OnErrorCallback = void Function(String? error);

abstract class ApiInterface {
  Future<HomeData?> loadData({
    OnErrorCallback? onError,
    int page = 1,
  });

  Future<HomeData?> searchData({
    String? q,
    int page = 1,
  });
}