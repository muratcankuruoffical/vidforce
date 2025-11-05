import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../data/providers/templates_provider.dart';
import '../../data/providers/balance_provider.dart';

class TemplateDetailScreen extends ConsumerWidget {
  const TemplateDetailScreen({
    required this.templateId,
    super.key,
  });

  final String templateId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final templateAsync = ref.watch(templateByIdProvider(templateId));
    final balanceAsync = ref.watch(balanceProvider);

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: templateAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
        data: (template) {
          if (template == null) {
            return const Center(child: Text('Template not found'));
          }

          final canAfford = balanceAsync.value?.canAfford(template.creditCost) ?? false;

          return CustomScrollView(
            slivers: [
              // App Bar
              SliverAppBar(
                expandedHeight: 300,
                pinned: true,
                backgroundColor: AppColors.bg,
                leading: IconButton(
                  icon: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.bg.withOpacity(0.8),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.arrow_back, color: AppColors.text),
                  ),
                  onPressed: () => context.pop(),
                ),
                actions: [
                  IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.bg.withOpacity(0.8),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.share, color: AppColors.text),
                    ),
                    onPressed: () {
                      // Share template
                    },
                  ),
                  IconButton(
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.bg.withOpacity(0.8),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.favorite_border,
                        color: AppColors.text,
                      ),
                    ),
                    onPressed: () {
                      // Toggle favorite
                    },
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      CachedNetworkImage(
                        imageUrl: template.coverUrl,
                        fit: BoxFit.cover,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              AppColors.bg.withOpacity(0.8),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Content
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title and badges
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              template.title,
                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                                color: AppColors.text,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.md),
                      // Badges
                      Wrap(
                        spacing: AppSpacing.sm,
                        runSpacing: AppSpacing.sm,
                        children: [
                          _InfoChip(
                            icon: Icons.bolt,
                            label: '${template.creditCost} credits',
                            color: AppColors.lime,
                          ),
                          _InfoChip(
                            icon: Icons.star,
                            label: template.rating.toStringAsFixed(1),
                            color: AppColors.warn,
                          ),
                          _InfoChip(
                            icon: Icons.people,
                            label: '${template.usageCount}+ uses',
                            color: AppColors.blue,
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      // Description
                      const Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.text,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        template.shortDescription,
                        style: const TextStyle(
                          fontSize: 15,
                          color: AppColors.text2,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      // Requirements
                      const Text(
                        'What You Need',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.text,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      ...template.requirements.map(
                        (req) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.check_circle,
                                size: 20,
                                color: AppColors.success,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                req,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: AppColors.text2,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      // Aspect ratios
                      const Text(
                        'Available Formats',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: AppColors.text,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Wrap(
                        spacing: AppSpacing.sm,
                        children: template.aspectRatios.map((ar) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.card,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColors.stroke),
                            ),
                            child: Text(
                              ar,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.text,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: AppSpacing.xxxl),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: templateAsync.whenData((template) {
        if (template == null) return null;

        return Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.surface,
            border: Border(
              top: BorderSide(color: AppColors.stroke),
            ),
          ),
          child: SafeArea(
            child: ElevatedButton(
              onPressed: () {
                final canAfford =
                    balanceAsync.value?.canAfford(template.creditCost) ??
                        false;
                if (canAfford) {
                  context.push('/generate/${template.id}');
                } else {
                  _showInsufficientCreditsDialog(context);
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 18),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.auto_awesome),
                  const SizedBox(width: 8),
                  const Text('Use Template'),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.bg.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.bolt, size: 14),
                        const SizedBox(width: 4),
                        Text(template.creditCost.toString()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).value,
    );
  }

  void _showInsufficientCreditsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.card,
        title: const Text('Insufficient Credits'),
        content: const Text(
          'You don\'t have enough credits for this template. Would you like to purchase more?',
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              context.pop();
              context.push('/account/credits');
            },
            child: const Text('Buy Credits'),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
