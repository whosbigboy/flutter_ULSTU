// home.dart
import 'card.dart';

class HomeData {
  final List<CardData>? data;
  final bool hasNextPage;
  final int currentPage;
  final int lastVisiblePage;

  HomeData({
    this.data,
    this.hasNextPage = false,
    this.currentPage = 1,
    this.lastVisiblePage = 1,
  });
}