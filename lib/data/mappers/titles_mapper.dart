import 'package:flutter_app/data/dtos/titles_dto.dart';
import 'package:flutter_app/domain/models/card.dart';

import '../../domain/models/home.dart';

extension TitleDataDtoToModel on TitleDataDto {
  CardData toDomain() => CardData(
    titleEnglish ?? title ?? "No title",
    imageUrl: images?.jpg?.largeImageUrl ??
        images?.jpg?.imageUrl ??
        'https://i.pinimg.com/736x/51/58/3d/51583d3365337490861dc1a6234e148a.jpg',
    descriptionText: 'Оценка: ${score ?? 'Не оценивали'}\nЭпизодов: ${episodes ?? '?'}',
    id: malId?.toString(),
  );
}

// titles_mapper.dart
extension TitleDtoToModel on TitlesDto {
  HomeData toDomain() => HomeData(
    data: data?.map((e) => e.toDomain()).toList() ?? [],
    hasNextPage: pagination?.hasNextPage ?? false,
    currentPage: pagination?.currentPage ?? 1,
    lastVisiblePage: pagination?.lastVisiblePage ?? 1,
  );
}