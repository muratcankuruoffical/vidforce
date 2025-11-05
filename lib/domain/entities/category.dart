/// Template category
class Category {
  final String id;
  final String name;
  final String emoji;
  final String? gradient;

  const Category({
    required this.id,
    required this.name,
    required this.emoji,
    this.gradient,
  });
}
