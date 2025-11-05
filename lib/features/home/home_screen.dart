import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/widgets/credit_badge.dart';
import '../../core/widgets/template_card.dart';
import '../../core/widgets/category_pill.dart';
import '../../core/widgets/loading_shimmer.dart';
import '../../data/providers/templates_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final featuredAsync = ref.watch(featuredTemplatesProvider);
    final trendingAsync = ref.watch(trendingTemplatesProvider);
    final categories = ref.watch(categoriesProvider);

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            floating: true,
            backgroundColor: AppColors.bg,
            elevation: 0,
            title: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    gradient: AppColors.limeGradient,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'VidForce',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: AppColors.bg,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
              ],
            ),
            actions: const [
              CreditBadge(),
              SizedBox(width: AppSpacing.md),
            ],
          ),
          // Featured Section
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppSpacing.md),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.star_rounded,
                            color: AppColors.warn,
                            size: 24,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'Featured',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: AppColors.text,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Handpicked templates for you',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.text2,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                SizedBox(
                  height: 280,
                  child: featuredAsync.when(
                    loading: () => ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                      ),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Container(
                          width: 200,
                          margin: const EdgeInsets.only(right: AppSpacing.md),
                          child: const TemplateCardShimmer(),
                        );
                      },
                    ),
                    error: (error, stack) => Center(
                      child: Text('Error: $error'),
                    ),
                    data: (templates) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                        ),
                        itemCount: templates.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 200,
                            margin: const EdgeInsets.only(
                              right: AppSpacing.md,
                            ),
                            child: TemplateCard(template: templates[index])
                                .animate()
                                .fadeIn(
                                  delay: (index * 100).ms,
                                  duration: 400.ms,
                                )
                                .slideX(begin: 0.2, end: 0),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          // Trending Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  const Icon(
                    Icons.local_fire_department,
                    color: AppColors.danger,
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Trending Now',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.text,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Trending Grid
          trendingAsync.when(
            loading: () => SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: AppSpacing.md,
                  mainAxisSpacing: AppSpacing.md,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) => const TemplateCardShimmer(),
                  childCount: 4,
                ),
              ),
            ),
            error: (error, stack) => SliverToBoxAdapter(
              child: Center(child: Text('Error: $error')),
            ),
            data: (templates) {
              return SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                sliver: SliverGrid(
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: AppSpacing.md,
                    mainAxisSpacing: AppSpacing.md,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return TemplateCard(template: templates[index])
                          .animate()
                          .fadeIn(
                            delay: (index * 100).ms,
                            duration: 400.ms,
                          )
                          .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1));
                    },
                    childCount: templates.length,
                  ),
                ),
              );
            },
          ),
          // Categories Section
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppSpacing.lg),
                  Row(
                    children: [
                      const Icon(
                        Icons.grid_view_rounded,
                        color: AppColors.blue,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Explore Categories',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.text,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1,
                      crossAxisSpacing: AppSpacing.sm,
                      mainAxisSpacing: AppSpacing.sm,
                    ),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return CategoryPill(
                        category: categories[index],
                        onTap: () {
                          // Navigate to category view
                          context.push(
                            '/category/${categories[index].id}',
                          );
                        },
                      )
                          .animate()
                          .fadeIn(
                            delay: (index * 50).ms,
                            duration: 400.ms,
                          )
                          .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1));
                    },
                  ),
                  const SizedBox(height: AppSpacing.xxxl),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
