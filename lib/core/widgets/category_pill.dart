import 'package:flutter/material.dart';
import '../../domain/entities/category.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';

/// Large rounded gradient tile for categories
class CategoryPill extends StatelessWidget {
  const CategoryPill({
    required this.category,
    required this.onTap,
    super.key,
  });

  final Category category;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          gradient: AppColors.cardGradient,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(
            color: AppColors.stroke,
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              category.icon,
              size: 36,
              color: category.color ?? AppColors.lime,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              category.name,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.text,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
