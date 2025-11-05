import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/template.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';

/// Card displaying template information
class TemplateCard extends StatelessWidget {
  const TemplateCard({
    required this.template,
    super.key,
  });

  final Template template;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/template/${template.id}'),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          boxShadow: AppColors.cardShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cover image
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(AppRadius.lg),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: template.coverUrl,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: AppColors.surface,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: AppColors.surface,
                        child: const Icon(Icons.error),
                      ),
                    ),
                  ),
                  // Type badge
                  Positioned(
                    left: AppSpacing.sm,
                    top: AppSpacing.sm,
                    child: _Badge(label: template.type.displayName),
                  ),
                  // Credit cost
                  Positioned(
                    right: AppSpacing.sm,
                    top: AppSpacing.sm,
                    child: _CostPill(cost: template.creditCost),
                  ),
                  // Trending badge
                  if (template.isTrending)
                    Positioned(
                      left: AppSpacing.sm,
                      bottom: AppSpacing.sm,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.danger.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(AppRadius.sm),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.local_fire_department,
                              size: 12,
                              color: Colors.white,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'TRENDING',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
            // Info
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      template.title,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.text,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          size: 14,
                          color: AppColors.warn,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          template.rating.toStringAsFixed(1),
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.text2,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '${template.usageCount}+ uses',
                          style: const TextStyle(
                            fontSize: 11,
                            color: AppColors.text2,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: AppColors.bg.withOpacity(0.8),
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: AppColors.text,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _CostPill extends StatelessWidget {
  const _CostPill({required this.cost});

  final int cost;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: AppColors.lime.withOpacity(0.9),
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.bolt,
            size: 12,
            color: AppColors.bg,
          ),
          const SizedBox(width: 2),
          Text(
            cost.toString(),
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppColors.bg,
            ),
          ),
        ],
      ),
    );
  }
}
