import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/creation.dart';
import 'api_provider.dart';

/// Provider for user's creations
final creationsProvider =
    StateNotifierProvider<CreationsNotifier, AsyncValue<List<Creation>>>((ref) {
  return CreationsNotifier(ref);
});

class CreationsNotifier extends StateNotifier<AsyncValue<List<Creation>>> {
  CreationsNotifier(this.ref) : super(const AsyncValue.loading()) {
    loadCreations();
  }

  final Ref ref;

  Future<void> loadCreations({CreationStatus? status}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final api = ref.read(apiServiceProvider);
      return api.getCreations(status: status);
    });
  }

  Future<void> toggleFavorite(String creationId) async {
    final api = ref.read(apiServiceProvider);
    await api.toggleFavorite(creationId);
    await loadCreations();
  }

  Future<void> deleteCreation(String creationId) async {
    final api = ref.read(apiServiceProvider);
    await api.deleteCreation(creationId);
    await loadCreations();
  }

  List<Creation> get favorites {
    return state.value?.where((c) => c.isFavorite).toList() ?? [];
  }
}

/// Provider for creation by ID
final creationByIdProvider =
    FutureProvider.family<Creation?, String>((ref, id) async {
  final api = ref.read(apiServiceProvider);
  return api.getCreationById(id);
});

/// Provider for filter status
final creationFilterProvider = StateProvider<CreationStatus?>((ref) => null);
