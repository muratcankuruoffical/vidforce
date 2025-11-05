import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/user_balance.dart';
import '../../domain/entities/credit_pack.dart';
import 'api_provider.dart';

/// Provider for user balance
final balanceProvider =
    StateNotifierProvider<BalanceNotifier, AsyncValue<UserBalance>>((ref) {
  return BalanceNotifier(ref);
});

class BalanceNotifier extends StateNotifier<AsyncValue<UserBalance>> {
  BalanceNotifier(this.ref) : super(const AsyncValue.loading()) {
    loadBalance();
  }

  final Ref ref;

  Future<void> loadBalance() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final api = ref.read(apiServiceProvider);
      return api.getBalance();
    });
  }

  Future<void> purchaseCredits(String packId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final api = ref.read(apiServiceProvider);
      return api.purchaseCredits(packId);
    });
  }

  bool canAfford(int cost) {
    return state.value?.canAfford(cost) ?? false;
  }
}

/// Provider for credit packs
final creditPacksProvider =
    FutureProvider<List<CreditPack>>((ref) async {
  final api = ref.read(apiServiceProvider);
  return api.getCreditPacks();
});
