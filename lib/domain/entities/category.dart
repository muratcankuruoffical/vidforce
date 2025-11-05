import 'package:flutter/material.dart';

/// Template category
class Category {
  final String id;
  final String name;
  final IconData icon;
  final Color? color;

  const Category({
    required this.id,
    required this.name,
    required this.icon,
    this.color,
  });
}
