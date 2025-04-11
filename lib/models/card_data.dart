import 'package:flutter/material.dart';

class CardData {
  final String id;
  final String imageUrl;
  final String category; // Like "Al día en Marketing, Tende..."
  final String title;
  final String status; // "Nuevo", "9% leído", etc.
  final Color backgroundColor;
  final bool isAudio; // To show "Escucha 5m" or similar

  CardData({
    required this.id,
    required this.imageUrl,
    required this.category,
    required this.title,
    required this.status,
    required this.backgroundColor,
    this.isAudio = false,
  });
}