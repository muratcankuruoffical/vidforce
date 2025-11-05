import 'package:flutter/material.dart';
import '../../domain/entities/credit_pack.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';

/// Card for displaying credit pack
class CreditPackCard extends StatelessWidget {
  const CreditPackCard({
    required this.pack,
    required this.onTap,
    super.key,
  });

  final CreditPack pack;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 200,
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          gradient: pack.isBestValue
              ? AppColors.limeGradient
              : AppColors.cardGradient,
          borderRadius: BorderRadius.circular(AppRadius.xl),
          border: Border.all(
            color: pack.isBestValue ? AppColors.lime : AppColors.stroke,
            width: pack.isBestValue ? 2 : 1.5,
          ),
          boxShadow: pack.isBestValue ? [AppColors.accentGlow] : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (pack.isBestValue)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.bg,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: const Text(
                  'BEST VALUE',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: AppColors.lime,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            if (pack.isBestValue) const SizedBox(height: AppSpacing.sm),
            Text(
              pack.title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: pack.isBestValue ? AppColors.bg : AppColors.text,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.bolt,
                  size: 28,
                  color: pack.isBestValue ? AppColors.bg : AppColors.lime,
                ),
                const SizedBox(width: 4),
                Text(
                  pack.credits.toString(),
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: pack.isBestValue ? AppColors.bg : AppColors.text,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'credits',
              style: TextStyle(
                fontSize: 13,
                color:
                    pack.isBestValue ? AppColors.bg : AppColors.text2,
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: pack.isBestValue
                    ? AppColors.bg
                    : AppColors.lime,
                borderRadius: BorderRadius.circular(AppRadius.lg),
              ),
              child: Text(
                pack.formattedPrice,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: pack.isBestValue ? AppColors.lime : AppColors.bg,
                ),
              ),
            ),
            if (pack.description != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(
                pack.description!,
                style: TextStyle(
                  fontSize: 11,
                  color: pack.isBestValue
                      ? AppColors.bg.withOpacity(0.8)
                      : AppColors.text2,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            if (pack.discount != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: Text(
                  'Save ${pack.discount!.toInt()}%',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: pack.isBestValue ? AppColors.bg : AppColors.success,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
