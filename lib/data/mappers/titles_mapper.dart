
import 'package:flutter_app/data/dtos/titles_dto.dart';
import 'package:flutter_app/domain/models/card.dart';

extension TitleDataDtoToModel on TitleDataDto {
  CardData toDomain() => CardData(
    title_english ?? title_default ?? "No title",
    imageUrl: images?.jpg?.large_image_url ?? images?.jpg?.image_url,
    descriptionText: 'Оценка: ${score}\nЭпизодов: ${episodes}',
  );
}

