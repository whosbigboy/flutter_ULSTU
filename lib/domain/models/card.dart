import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class CardData {
  final String text;
  final String descriptionText;
  final IconData icon;
  final String? imageUrl;
  final String? id;

  CardData(
    this.text, {
    required this.descriptionText,
    this.icon = Icons.abc,
    this.imageUrl,
    this.id
  });
}

typedef OnLikeCallBack = void Function(String title, bool isLiked)?;
