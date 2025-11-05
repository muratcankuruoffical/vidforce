import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/template.dart';
import '../../domain/entities/category.dart';
import '../api/mock_data.dart';
import 'api_provider.dart';

/// Provider for all templates
final templatesProvider = FutureProvider<List<Template>>((ref) async {
  final api = ref.read(apiServiceProvider);
  return api.getTemplates();
});

/// Provider for featured templates
final featuredTemplatesProvider = FutureProvider<List<Template>>((ref) async {
  final api = ref.read(apiServiceProvider);
  return api.getFeaturedTemplates();
});

/// Provider for trending templates
final trendingTemplatesProvider = FutureProvider<List<Template>>((ref) async {
  final api = ref.read(apiServiceProvider);
  return api.getTrendingTemplates();
});

/// Provider for template by ID
final templateByIdProvider =
    FutureProvider.family<Template?, String>((ref, id) async {
  final api = ref.read(apiServiceProvider);
  return api.getTemplateById(id);
});

/// Provider for templates by category
final templatesByCategoryProvider =
    FutureProvider.family<List<Template>, String>((ref, category) async {
  final api = ref.read(apiServiceProvider);
  return api.getTemplatesByCategory(category);
});

/// Provider for categories
final categoriesProvider = Provider<List<Category>>((ref) {
  return MockData.categories;
});

/// Provider for selected category filter
final selectedCategoryProvider = StateProvider<String?>((ref) => null);
