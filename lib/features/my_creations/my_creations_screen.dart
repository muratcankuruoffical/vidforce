import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/widgets/empty_state.dart';
import '../../data/providers/creations_provider.dart';
import '../../domain/entities/creation.dart';

class MyCreationsScreen extends ConsumerWidget {
  const MyCreationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final creationsAsync = ref.watch(creationsProvider);

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        title: const Text('My Creations'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {},
          ),
        ],
      ),
      body: creationsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
        data: (creations) {
          if (creations.isEmpty) {
            return const EmptyState(
              icon: Icons.photo_library_rounded,
              title: 'No Creations Yet',
              description:
                  'Start creating amazing content with our AI-powered templates!',
              actionLabel: 'Browse Templates',
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(AppSpacing.md),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: AppSpacing.md,
              mainAxisSpacing: AppSpacing.md,
            ),
            itemCount: creations.length,
            itemBuilder: (context, index) {
              final creation = creations[index];
              return _CreationCard(creation: creation);
            },
          );
        },
      ),
    );
  }
}

class _CreationCard extends StatelessWidget {
  const _CreationCard({required this.creation});

  final Creation creation;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (creation.status.isCompleted) {
          context.push('/result/${creation.id}');
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(AppRadius.lg),
        ),
        child: Stack(
          children: [
            // Thumbnail
            if (creation.thumbnailUrl != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.lg),
                child: CachedNetworkImage(
                  imageUrl: creation.thumbnailUrl!,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            // Status overlay
            if (creation.status.isProcessing)
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                ),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            // Info
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.8),
                    ],
                  ),
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(AppRadius.lg),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      creation.templateTitle,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      creation.status.displayName,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.white.withOpacity(0.8),
                      ),
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
