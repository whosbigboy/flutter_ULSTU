import 'package:json_annotation/json_annotation.dart';

part 'titles_dto.g.dart';

@JsonSerializable(createToJson: false)
class TitleDto{
  final List<TitleDataDto>? data;

  const TitleDto({this.data});

  factory TitleDto.fromJson(Map<String, dynamic> json) => _$TitleDtoFromJson(json);
}

@JsonSerializable(createToJson: false)
class TitleDataDto{

const TitleDataDto();

factory TitleDataDto.fromJson(Map<String, dynamic> json) => _$TitleDataDtoFromJson(json);
}