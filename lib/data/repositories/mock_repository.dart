// mock_repository.dart
import 'package:flutter_app/data/repositories/api_interface.dart';
import 'package:flutter_app/domain/models/card.dart';
import 'package:flutter/material.dart';

import '../../domain/models/home.dart';

class MockRepository extends ApiInterface {
  final List<CardData> _mockData = [
    CardData(
      "Gurren Lagann",
      descriptionText: "omg bro who the hell do u think Kanima and Simon are? Row row fight to power",
      imageUrl: "https://i.pinimg.com/1200x/5f/f2/40/5ff240b0b79e342d1729a058190ad206.jpg",
    ),
    CardData(
      "Cowboy Bebop",
      descriptionText: "cowboys in the space? smth like that. if u wannna listen to space jazz, u r welcome",
      icon: Icons.account_box,
      imageUrl: "https://i.pinimg.com/1200x/ce/26/74/ce267476fbbe391d72f0c091c27c7071.jpg",
    ),
    CardData(
      "Akira",
      descriptionText: "cool boy on the bike. and experiments on children in neo-tokyo",
      icon: Icons.account_box,
      imageUrl: "https://i.pinimg.com/736x/3c/f3/da/3cf3da42abdef05e075cdebe52e48068.jpg",
    ),
    CardData(
      "Neon Genesis Evangelion",
      descriptionText: "hedgehog's dillema and many many many other problems",
      imageUrl: "https://i.pinimg.com/736x/0d/ee/db/0deedb6bbbbd2b17b2ab4495ca02f9c2.jpg",
    ),
    CardData(
      "Jojo's Bizarre Adventure",
      descriptionText: "new season, new some jojo's relative",
      imageUrl: "https://i.pinimg.com/1200x/3d/18/98/3d18985ce820ee790fbfeaf422a81e3c.jpg",
    ),
    CardData(
      "Grand blue",
      descriptionText: "men just chilling and vibing and drinking without sobering up and sometimes diving and rarely studying",
      imageUrl: "https://i.pinimg.com/736x/e6/56/36/e65636fe7c241dcf163d16f3c574caad.jpg",
    ),

    CardData(
      "Attack on Titan",
      descriptionText: "giant naked people attacking walls and humanity's struggle for survival",
      imageUrl: "https://i.pinimg.com/736x/45/12/a1/4512a11c94d56b3c8b03d4d4eebc7156.jpg",
    ),
    CardData(
      "Death Note",
      descriptionText: "genius high school student with a notebook that can kill people",
      imageUrl: "https://i.pinimg.com/736x/98/a4/d8/98a4d8c5b70b6b4d8e5b8e7a6c5f3b2a.jpg",
    ),
    CardData(
      "Fullmetal Alchemist: Brotherhood",
      descriptionText: "two brothers searching for the philosopher's stone after a failed alchemy experiment",
      imageUrl: "https://i.pinimg.com/736x/67/89/4a/67894a8b5e5b5e5b5e5b5e5b5e5b5e5b.jpg",
    ),
    CardData(
      "One Punch Man",
      descriptionText: "hero who can defeat any opponent with a single punch but is bored of his power",
      imageUrl: "https://i.pinimg.com/736x/12/34/56/1234567890abcdef1234567890abcdef.jpg",
    ),
    CardData(
      "Demon Slayer",
      descriptionText: "young boy becomes a demon slayer to save his sister and avenge his family",
      imageUrl: "https://i.pinimg.com/736x/ab/cd/ef/abcdef1234567890abcdef1234567890.jpg",
    ),
    CardData(
      "My Hero Academia",
      descriptionText: "quirkless boy inherits power to become the greatest hero",
      imageUrl: "https://i.pinimg.com/736x/12/34/56/1234567890abcdef1234567890abcdef.jpg",
    ),
    CardData(
      "Naruto",
      descriptionText: "young ninja's journey to become Hokage and be acknowledged by his village",
      imageUrl: "https://i.pinimg.com/736x/34/56/78/34567890123456789012345678901234.jpg",
    ),
    CardData(
      "Bleach",
      descriptionText: "high school student becomes a Soul Reaper to protect humans from evil spirits",
      imageUrl: "https://i.pinimg.com/736x/56/78/90/56789012345678901234567890123456.jpg",
    ),
    CardData(
      "One Piece",
      descriptionText: "pirate crew searching for the ultimate treasure in a world of oceans",
      imageUrl: "https://i.pinimg.com/736x/78/90/12/78901234567890123456789012345678.jpg",
    ),
    CardData(
      "Hunter x Hunter",
      descriptionText: "young boy becomes a Hunter to find his father and explore the world",
      imageUrl: "https://i.pinimg.com/736x/90/12/34/90123456789012345678901234567890.jpg",
    ),
    CardData(
      "Tokyo Ghoul",
      descriptionText: "college student becomes half-ghoul and struggles between human and ghoul worlds",
      imageUrl: "https://i.pinimg.com/736x/12/34/56/1234567890abcdef1234567890abcdef.jpg",
    ),
    CardData(
      "Parasyte",
      descriptionText: "high school student's right hand is taken over by an alien parasite",
      imageUrl: "https://i.pinimg.com/736x/34/56/78/34567890123456789012345678901234.jpg",
    ),
    CardData(
      "Mob Psycho 100",
      descriptionText: "powerful psychic middle schooler tries to live a normal life",
      imageUrl: "https://i.pinimg.com/736x/56/78/90/56789012345678901234567890123456.jpg",
    ),
    CardData(
      "Vinland Saga",
      descriptionText: "young viking's quest for revenge in the age of Norse expansion",
      imageUrl: "https://i.pinimg.com/736x/78/90/12/78901234567890123456789012345678.jpg",
    ),
  ];

  @override
  Future<HomeData?> loadData({
    OnErrorCallback? onError,
    int page = 1,
  }) async {
    // Имитируем задержку сети
    await Future.delayed(const Duration(milliseconds: 500));

    final itemsPerPage = 6;
    final startIndex = (page - 1) * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;

    // Проверяем, не вышли ли за пределы списка
    if (startIndex >= _mockData.length) {
      return HomeData(
        data: [],
        hasNextPage: false,
        currentPage: page,
        lastVisiblePage: (_mockData.length / itemsPerPage).ceil(),
      );
    }

    final paginatedData = _mockData.sublist(
      startIndex,
      endIndex < _mockData.length ? endIndex : _mockData.length,
    );

    final hasNextPage = endIndex < _mockData.length;
    final lastVisiblePage = (_mockData.length / itemsPerPage).ceil();

    return HomeData(
      data: paginatedData,
      hasNextPage: hasNextPage,
      currentPage: page,
      lastVisiblePage: lastVisiblePage,
    );
  }

  @override
  Future<HomeData?> searchData({
    String? q,
    int page = 1,
  }) async {
    // Имитируем задержку сети
    await Future.delayed(const Duration(milliseconds: 500));

    if (q == null || q.isEmpty) {
      return loadData(page: page);
    }

    final searchResults = _mockData.where((item) =>
    item.text.toLowerCase().contains(q.toLowerCase()) ||
        item.descriptionText.toLowerCase().contains(q.toLowerCase())
    ).toList();

    final itemsPerPage = 6;
    final startIndex = (page - 1) * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;

    if (startIndex >= searchResults.length) {
      return HomeData(
        data: [],
        hasNextPage: false,
        currentPage: page,
        lastVisiblePage: (searchResults.length / itemsPerPage).ceil(),
      );
    }

    final paginatedData = searchResults.sublist(
      startIndex,
      endIndex < searchResults.length ? endIndex : searchResults.length,
    );

    final hasNextPage = endIndex < searchResults.length;
    final lastVisiblePage = (searchResults.length / itemsPerPage).ceil();

    return HomeData(
      data: paginatedData,
      hasNextPage: hasNextPage,
      currentPage: page,
      lastVisiblePage: lastVisiblePage,
    );
  }
}