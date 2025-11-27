// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'titles_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TitlesDto _$TitlesDtoFromJson(Map<String, dynamic> json) => TitlesDto(
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => TitleDataDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  pagination: json['pagination'] == null
      ? null
      : PaginationDto.fromJson(json['pagination'] as Map<String, dynamic>),
);

TitleDataDto _$TitleDataDtoFromJson(Map<String, dynamic> json) => TitleDataDto(
  titleEnglish: json['title_english'] as String?,
  title: json['title'] as String?,
  score: (json['score'] as num?)?.toDouble(),
  episodes: (json['episodes'] as num?)?.toInt(),
  images: json['images'] == null
      ? null
      : TitleImagesDto.fromJson(json['images'] as Map<String, dynamic>),
);

TitleImagesDto _$TitleImagesDtoFromJson(Map<String, dynamic> json) =>
    TitleImagesDto(
      jpg: json['jpg'] == null
          ? null
          : TitleImageDto.fromJson(json['jpg'] as Map<String, dynamic>),
    );

TitleImageDto _$TitleImageDtoFromJson(Map<String, dynamic> json) =>
    TitleImageDto(
      imageUrl: json['image_url'] as String?,
      largeImageUrl: json['large_image_url'] as String?,
    );

PaginationDto _$PaginationDtoFromJson(Map<String, dynamic> json) =>
    PaginationDto(
      lastVisiblePage: (json['last_visible_page'] as num?)?.toInt(),
      hasNextPage: json['has_next_page'] as bool?,
      currentPage: (json['current_page'] as num?)?.toInt(),
    );
