// anime_repository.dart
import 'package:dio/dio.dart';
import 'package:flutter_app/data/mappers/titles_mapper.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../domain/models/home.dart';
import '../dtos/titles_dto.dart';
import 'api_interface.dart';

class AnimeRepository extends ApiInterface {
  static final Dio _dio = Dio()
    ..interceptors.add(PrettyDioLogger(requestHeader: true, requestBody: true));

  static const String _baseUrl = 'https://api.jikan___.moe/v4/';

  @override
  Future<HomeData?> loadData({
    OnErrorCallback? onError,
    int page = 1,
  }) async {
    try {
      const String url = '${_baseUrl}top/anime';
      final Response<dynamic> response = await _dio.get<Map<dynamic, dynamic>>(
        url,
        queryParameters: {
          'page': page,
          'limit': 10
        },
      );
      final TitlesDto dto = TitlesDto.fromJson(response.data as Map<String, dynamic>);
      final HomeData data = dto.toDomain();
      return data;
    } on DioException catch (e) {
      onError?.call(e.error?.toString());
      return null;
    }
  }

  Future<HomeData?> searchData({
    String? q,
    int page = 1,
  }) async {
    try {
      final String url = '${_baseUrl}anime';
      final Response<dynamic> response = await _dio.get<Map<dynamic, dynamic>>(
        url,
        queryParameters: {
          'q': q,
          'limit': 10,
          'order_by': 'popularity',
          'sort': 'asc',
          'page': page,
        },
      );

      final TitlesDto dto = TitlesDto.fromJson(response.data as Map<String, dynamic>);
      final HomeData data = dto.toDomain();
      return data;
    } on DioException catch (e) {
      print('Search error: $e');
      return null;
    }
  }
}