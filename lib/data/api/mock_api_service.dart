import '../../domain/entities/template.dart';
import '../../domain/entities/creation.dart';
import '../../domain/entities/user_balance.dart';
import '../../domain/entities/credit_pack.dart';
import 'mock_data.dart';

/// Mock API service for development
class MockApiService {
  // Simulate network delay
  Future<void> _delay([int milliseconds = 800]) =>
      Future.delayed(Duration(milliseconds: milliseconds));

  /// Get all templates
  Future<List<Template>> getTemplates({
    String? category,
    String? sort,
  }) async {
    await _delay();

    var templates = MockData.templates;

    if (category != null && category.isNotEmpty) {
      templates = templates
          .where((t) => t.categories.contains(category))
          .toList();
    }

    if (sort == 'trending') {
      templates = templates.where((t) => t.isTrending).toList();
    } else if (sort == 'featured') {
      templates = templates.where((t) => t.isFeatured).toList();
    }

    return templates;
  }

  /// Get featured templates
  Future<List<Template>> getFeaturedTemplates() async {
    await _delay(500);
    return MockData.templates.where((t) => t.isFeatured).toList();
  }

  /// Get trending templates
  Future<List<Template>> getTrendingTemplates() async {
    await _delay(500);
    return MockData.templates.where((t) => t.isTrending).toList();
  }

  /// Get template by ID
  Future<Template?> getTemplateById(String id) async {
    await _delay(400);
    try {
      return MockData.templates.firstWhere((t) => t.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Get templates by category
  Future<List<Template>> getTemplatesByCategory(String category) async {
    await _delay(600);
    return MockData.templates
        .where((t) => t.categories.contains(category))
        .toList();
  }

  /// Get user's creations
  Future<List<Creation>> getCreations({CreationStatus? status}) async {
    await _delay(700);

    var creations = MockData.sampleCreations;

    if (status != null) {
      creations = creations.where((c) => c.status == status).toList();
    }

    return creations;
  }

  /// Get creation by ID
  Future<Creation?> getCreationById(String id) async {
    await _delay(300);
    try {
      return MockData.sampleCreations.firstWhere((c) => c.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Start a new generation
  Future<Creation> generateMedia({
    required String templateId,
    required List<String> assetPaths,
    required String aspectRatio,
  }) async {
    await _delay(1000);

    // Create a new creation in processing state
    final template = await getTemplateById(templateId);
    if (template == null) {
      throw Exception('Template not found');
    }

    return Creation(
      id: 'cr_${DateTime.now().millisecondsSinceEpoch}',
      templateId: templateId,
      templateTitle: template.title,
      type: template.type,
      status: CreationStatus.processing,
      createdAt: DateTime.now(),
      creditsCost: template.creditCost,
      progress: 0.1,
    );
  }

  /// Get user balance
  Future<UserBalance> getBalance() async {
    await _delay(300);
    return MockData.userBalance;
  }

  /// Get credit packs
  Future<List<CreditPack>> getCreditPacks() async {
    await _delay(400);
    return MockData.creditPacks;
  }

  /// Purchase credits
  Future<UserBalance> purchaseCredits(String packId) async {
    await _delay(1500);

    final pack = MockData.creditPacks.firstWhere((p) => p.id == packId);
    final newBalance = MockData.userBalance.credits + pack.credits;

    MockData.userBalance = UserBalance(
      credits: newBalance,
      lastUpdated: DateTime.now(),
    );

    return MockData.userBalance;
  }

  /// Toggle favorite on creation
  Future<Creation> toggleFavorite(String creationId) async {
    await _delay(200);

    final creation = await getCreationById(creationId);
    if (creation == null) {
      throw Exception('Creation not found');
    }

    return creation.copyWith(isFavorite: !creation.isFavorite);
  }

  /// Delete creation
  Future<void> deleteCreation(String creationId) async {
    await _delay(300);
    // In real app, would delete from backend
  }
}
