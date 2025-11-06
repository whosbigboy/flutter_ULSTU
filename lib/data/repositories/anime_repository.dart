import 'package:flutter_app/data/mappers/titles_mapper.dart';
import 'package:flutter_app/data/repositories/api_interface.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:dio/dio.dart';

import '../../domain/models/card.dart';
import '../dtos/titles_dto.dart';

class AnimeRepository extends ApiInterface {
  static final Dio _dio = Dio()
    ..interceptors.add(PrettyDioLogger(requestHeader: true, requestBody: true));

  static const String _baseUrl = 'https://api.jikan.moe/v4/';

  @override
  Future<List<CardData>?> loadData({String? q}) async {
    try {
      const String url = '${_baseUrl}top/anime';
      final Response<dynamic> response = await _dio.get<Map<dynamic, dynamic>>(url);
      final TitleDto dto = TitleDto.fromJson(response.data as Map<String, dynamic>);
      final List<CardData>? data = dto.data?.map((e) => e.toDomain()).toList();
      return data;
    } on DioException catch (e) {
      return null;
    }
  }

  @override
  Future<List<CardData>?> searchData({String? q}) async {
    try {
      final String url = '${_baseUrl}anime';
      final Response<dynamic> response = await _dio.get<Map<dynamic, dynamic>>(
        url,
        queryParameters: {
          'q': q,
          'limit': 25,
          'order_by': 'popularity',
          'sort': 'asc',
        },
      );

      final TitleDto dto = TitleDto.fromJson(response.data as Map<String, dynamic>);
      final List<CardData>? data = dto.data?.map((e) => e.toDomain()).toList();
      return data;
    } on DioException catch (e) {
      print('Search error: $e');
      return null;
    }
  }
}