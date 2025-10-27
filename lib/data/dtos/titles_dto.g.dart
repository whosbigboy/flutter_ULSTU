// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'titles_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TitleDto _$TitleDtoFromJson(Map<String, dynamic> json) => TitleDto(
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => TitleDataDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

TitleDataDto _$TitleDataDtoFromJson(Map<String, dynamic> json) => TitleDataDto(
  title_english: json['title_english'] as String?,
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
      image_url: json['image_url'] as String?,
      large_image_url: json['large_image_url'] as String?,
    );
