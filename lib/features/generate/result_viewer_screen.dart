import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';

class ResultViewerScreen extends StatelessWidget {
  const ResultViewerScreen({
    required this.creationId,
    super.key,
  });

  final String creationId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: Center(
        child: CachedNetworkImage(
          imageUrl: 'https://picsum.photos/seed/result/800/800',
          fit: BoxFit.contain,
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.black.withOpacity(0.8),
        padding: const EdgeInsets.all(AppSpacing.md),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _ActionButton(
                icon: Icons.download,
                label: 'Save',
                onTap: () {},
              ),
              _ActionButton(
                icon: Icons.share,
                label: 'Share',
                onTap: () {},
              ),
              _ActionButton(
                icon: Icons.favorite_border,
                label: 'Favorite',
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
