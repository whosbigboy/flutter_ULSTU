import 'package:flutter_app/data/dtos/titles_dto.dart';
import 'package:flutter_app/domain/models/card.dart';

extension TitleDataDtoToModel on TitleDataDto {
  CardData toDomain() => CardData(
    title_english ?? title ?? "No title",
    imageUrl:
        images?.jpg?.large_image_url ??
        images?.jpg?.image_url ??
        'https://i.pinimg.com/736x/51/58/3d/51583d3365337490861dc1a6234e148a.jpg',
    descriptionText: 'Оценка: ${score ?? 'Не оценивали'}'
        '\nЭпизодов: ${episodes}',
  );
}
