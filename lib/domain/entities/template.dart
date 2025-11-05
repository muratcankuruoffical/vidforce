import 'media_type.dart';

/// Template entity representing an AI generation template
class Template {
  final String id;
  final String title;
  final String coverUrl;
  final MediaType type;
  final List<String> categories;
  final List<String> aspectRatios;
  final int creditCost;
  final String shortDescription;
  final List<String> requirements;
  final String previewUrl;
  final double rating;
  final int usageCount;
  final bool isFeatured;
  final bool isTrending;

  const Template({
    required this.id,
    required this.title,
    required this.coverUrl,
    required this.type,
    required this.categories,
    required this.aspectRatios,
    required this.creditCost,
    required this.shortDescription,
    required this.requirements,
    required this.previewUrl,
    required this.rating,
    this.usageCount = 0,
    this.isFeatured = false,
    this.isTrending = false,
  });

  Template copyWith({
    String? id,
    String? title,
    String? coverUrl,
    MediaType? type,
    List<String>? categories,
    List<String>? aspectRatios,
    int? creditCost,
    String? shortDescription,
    List<String>? requirements,
    String? previewUrl,
    double? rating,
    int? usageCount,
    bool? isFeatured,
    bool? isTrending,
  }) {
    return Template(
      id: id ?? this.id,
      title: title ?? this.title,
      coverUrl: coverUrl ?? this.coverUrl,
      type: type ?? this.type,
      categories: categories ?? this.categories,
      aspectRatios: aspectRatios ?? this.aspectRatios,
      creditCost: creditCost ?? this.creditCost,
      shortDescription: shortDescription ?? this.shortDescription,
      requirements: requirements ?? this.requirements,
      previewUrl: previewUrl ?? this.previewUrl,
      rating: rating ?? this.rating,
      usageCount: usageCount ?? this.usageCount,
      isFeatured: isFeatured ?? this.isFeatured,
      isTrending: isTrending ?? this.isTrending,
    );
  }
}
