import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../../data/providers/balance_provider.dart';

/// Displays user's credit balance with tap to navigate to credit packs
class CreditBadge extends ConsumerWidget {
  const CreditBadge({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final balanceAsync = ref.watch(balanceProvider);

    return balanceAsync.when(
      loading: () => _buildBadge(context, '--'),
      error: (_, __) => _buildBadge(context, '0'),
      data: (balance) => _buildBadge(context, balance.credits.toString()),
    );
  }

  Widget _buildBadge(BuildContext context, String credits) {
    return InkWell(
      onTap: () => context.push('/account/credits'),
      borderRadius: BorderRadius.circular(AppRadius.full),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(AppRadius.full),
          border: Border.all(color: AppColors.stroke, width: 1.5),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.bolt,
              size: 18,
              color: AppColors.lime,
            ),
            const SizedBox(width: 6),
            Text(
              credits,
              style: const TextStyle(
                color: AppColors.text,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
