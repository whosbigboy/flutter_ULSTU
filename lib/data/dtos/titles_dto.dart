import 'package:json_annotation/json_annotation.dart';

part 'titles_dto.g.dart';

@JsonSerializable(createToJson: false)
class TitleDto {
  final List<TitleDataDto>? data;

  const TitleDto({this.data});

  factory TitleDto.fromJson(Map<String, dynamic> json) =>
      _$TitleDtoFromJson(json);
}

@JsonSerializable(createToJson: false)
class TitleDataDto {
  final String? title_english;
  final String? title;
  final double? score;
  final int? episodes;
  final TitleImagesDto? images;

  const TitleDataDto({
    this.title_english,
    this.title,
    this.score,
    this.episodes,
    this.images,
  });

  factory TitleDataDto.fromJson(Map<String, dynamic> json) =>
      _$TitleDataDtoFromJson(json);
}

@JsonSerializable(createToJson: false)
class TitleImagesDto {
  final TitleImageDto? jpg;

  const TitleImagesDto({this.jpg});

  factory TitleImagesDto.fromJson(Map<String, dynamic> json) =>
      _$TitleImagesDtoFromJson(json);
}

@JsonSerializable(createToJson: false)
class TitleImageDto {
  final String? image_url;
  final String? large_image_url;

  const TitleImageDto({this.image_url, this.large_image_url});

  factory TitleImageDto.fromJson(Map<String, dynamic> json) =>
      _$TitleImageDtoFromJson(json);
}
