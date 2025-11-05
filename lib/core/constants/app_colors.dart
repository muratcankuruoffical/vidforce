import 'package:flutter/material.dart';

/// Design tokens for VidForce dark-first color palette
class AppColors {
  AppColors._();

  // Backgrounds
  static const bg = Color(0xFF0D0F12);
  static const surface = Color(0xFF13161B);
  static const card = Color(0xFF181C22);
  static const stroke = Color(0xFF232A34);

  // Text
  static const text = Color(0xFFE8ECF3);
  static const text2 = Color(0xFFA9B3C4);

  // Accents
  static const lime = Color(0xFFC5FF3B);
  static const blue = Color(0xFF4DA3FF);

  // Semantic
  static const danger = Color(0xFFFF5D5D);
  static const warn = Color(0xFFFFD166);
  static const success = Color(0xFF62F5A3);

  // Gradients
  static const limeGradient = LinearGradient(
    colors: [Color(0xFFC5FF3B), Color(0xFF8FE61E)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const blueGradient = LinearGradient(
    colors: [Color(0xFF4DA3FF), Color(0xFF2E7FD9)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const cardGradient = LinearGradient(
    colors: [Color(0xFF1A1E26), Color(0xFF13161B)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Shadows
  static List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.2),
      blurRadius: 24,
      offset: const Offset(0, 8),
    ),
  ];

  static List<BoxShadow> elevatedShadow = [
    BoxShadow(
      color: Colors.black.withOpacity(0.3),
      blurRadius: 40,
      offset: const Offset(0, 16),
    ),
  ];

  static BoxShadow accentGlow = BoxShadow(
    color: lime.withOpacity(0.2),
    blurRadius: 20,
    spreadRadius: 0,
  );
}
