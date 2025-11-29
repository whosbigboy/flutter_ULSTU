import 'package:json_annotation/json_annotation.dart';

part 'titles_dto.g.dart';

@JsonSerializable(createToJson: false)
class TitlesDto {
  final List<TitleDataDto>? data;
  final PaginationDto? pagination;

  const TitlesDto({
    this.data,
    this.pagination,
  });

  factory TitlesDto.fromJson(Map<String, dynamic> json) => _$TitlesDtoFromJson(json);
}

@JsonSerializable(createToJson: false)
class TitleDataDto {
  @JsonKey(name: 'title_english')
  final String? titleEnglish;
  final String? title;
  final double? score;
  final int? episodes;
  final TitleImagesDto? images;
  final String? id;

  const TitleDataDto({
    this.titleEnglish,
    this.title,
    this.score,
    this.episodes,
    this.images,
    this.id,
  });

  factory TitleDataDto.fromJson(Map<String, dynamic> json) => _$TitleDataDtoFromJson(json);
}

@JsonSerializable(createToJson: false)
class TitleImagesDto {
  final TitleImageDto? jpg;

  const TitleImagesDto({this.jpg});

  factory TitleImagesDto.fromJson(Map<String, dynamic> json) => _$TitleImagesDtoFromJson(json);
}

@JsonSerializable(createToJson: false)
class TitleImageDto {
  @JsonKey(name: 'image_url')
  final String? imageUrl;
  @JsonKey(name: 'large_image_url')
  final String? largeImageUrl;

  const TitleImageDto({
    this.imageUrl,
    this.largeImageUrl,
  });

  factory TitleImageDto.fromJson(Map<String, dynamic> json) => _$TitleImageDtoFromJson(json);
}

@JsonSerializable(createToJson: false)
class PaginationDto {
  @JsonKey(name: 'last_visible_page')
  final int? lastVisiblePage;
  @JsonKey(name: 'has_next_page')
  final bool? hasNextPage;
  @JsonKey(name: 'current_page')
  final int? currentPage;

  const PaginationDto({
    this.lastVisiblePage,
    this.hasNextPage,
    this.currentPage,
  });

  factory PaginationDto.fromJson(Map<String, dynamic> json) => _$PaginationDtoFromJson(json);
}