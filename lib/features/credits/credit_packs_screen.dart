import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/widgets/credit_pack_card.dart';
import '../../data/providers/balance_provider.dart';

class CreditPacksScreen extends ConsumerWidget {
  const CreditPacksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final balanceAsync = ref.watch(balanceProvider);
    final packsAsync = ref.watch(creditPacksProvider);

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        title: const Text('Buy Credits'),
      ),
      body: Column(
        children: [
          // Current balance
          Container(
            margin: const EdgeInsets.all(AppSpacing.md),
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              gradient: AppColors.cardGradient,
              borderRadius: BorderRadius.circular(AppRadius.lg),
              border: Border.all(color: AppColors.stroke),
            ),
            child: Column(
              children: [
                const Text(
                  'Current Balance',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.text2,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                balanceAsync.when(
                  loading: () => const Text('--'),
                  error: (_, __) => const Text('0'),
                  data: (balance) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.bolt,
                        color: AppColors.lime,
                        size: 32,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        balance.credits.toString(),
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                          color: AppColors.text,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'credits',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.text2,
                  ),
                ),
              ],
            ),
          ),
          // Packs
          Expanded(
            child: packsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('Error: $error')),
              data: (packs) {
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: packs.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        right: AppSpacing.md,
                        bottom: AppSpacing.lg,
                      ),
                      child: CreditPackCard(
                        pack: packs[index],
                        onTap: () {
                          _showPurchaseDialog(
                            context,
                            ref,
                            packs[index].id,
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
          // FAQ
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'How Credits Work',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                const Text(
                  '• Image generation: 1-3 credits\n'
                  '• Video generation: 3-8 credits\n'
                  '• Credits never expire\n'
                  '• Refund available if generation fails',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.text2,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showPurchaseDialog(BuildContext context, WidgetRef ref, String packId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.card,
        title: const Text('Confirm Purchase'),
        content: const Text('This is a demo. Purchase functionality is not implemented.'),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              context.pop();
              // Simulate purchase
              await ref.read(balanceProvider.notifier).purchaseCredits(packId);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Credits added successfully!'),
                    backgroundColor: AppColors.success,
                  ),
                );
              }
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }
}
