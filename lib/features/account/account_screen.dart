import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/widgets/empty_state.dart';
import '../../data/providers/balance_provider.dart';
import '../../data/providers/creations_provider.dart';
import '../../domain/entities/creation.dart';

class AccountScreen extends ConsumerStatefulWidget {
  const AccountScreen({super.key});

  @override
  ConsumerState<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends ConsumerState<AccountScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final balanceAsync = ref.watch(balanceProvider);

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            // App Bar with user info
            SliverAppBar(
              expandedHeight: 200,
              floating: false,
              pinned: true,
              backgroundColor: AppColors.surface,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: AppColors.cardGradient,
                  ),
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          radius: 40,
                          backgroundColor: AppColors.lime,
                          child: Icon(
                            Icons.person,
                            size: 40,
                            color: AppColors.bg,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        const Text(
                          'User Name',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: AppColors.text,
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
                                size: 20,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${balance.credits} credits',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.text,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Tab Bar
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverTabBarDelegate(
                TabBar(
                  controller: _tabController,
                  labelColor: AppColors.lime,
                  unselectedLabelColor: AppColors.text2,
                  indicatorColor: AppColors.lime,
                  indicatorWeight: 3,
                  tabs: const [
                    Tab(
                      icon: Icon(Icons.photo_library_rounded),
                      text: 'My Creations',
                    ),
                    Tab(
                      icon: Icon(Icons.settings_rounded),
                      text: 'Settings',
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildMyCreationsTab(),
            _buildSettingsTab(context),
          ],
        ),
      ),
    );
  }

  // My Creations Tab
  Widget _buildMyCreationsTab() {
    final creationsAsync = ref.watch(creationsProvider);

    return creationsAsync.when(
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
    );
  }

  // Settings Tab
  Widget _buildSettingsTab(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      children: [
        _ListTile(
          icon: Icons.bolt,
          title: 'Buy Credits',
          subtitle: 'Get more credits to create',
          onTap: () => context.push('/account/credits'),
        ),
        const Divider(height: 1),
        _ListTile(
          icon: Icons.history,
          title: 'Purchase History',
          subtitle: 'View your transactions',
          onTap: () {},
        ),
        const Divider(height: 1),
        const SizedBox(height: AppSpacing.lg),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Text(
            'Preferences',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.text2,
            ),
          ),
        ),
        _ListTile(
          icon: Icons.dark_mode,
          title: 'Theme',
          subtitle: 'Dark mode (default)',
          onTap: () {},
        ),
        const Divider(height: 1),
        _ListTile(
          icon: Icons.notifications,
          title: 'Notifications',
          subtitle: 'Manage notifications',
          onTap: () {},
        ),
        const Divider(height: 1),
        const SizedBox(height: AppSpacing.lg),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Text(
            'Support',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.text2,
            ),
          ),
        ),
        _ListTile(
          icon: Icons.help,
          title: 'Help Center',
          subtitle: 'FAQs and support',
          onTap: () {},
        ),
        const Divider(height: 1),
        _ListTile(
          icon: Icons.privacy_tip,
          title: 'Privacy Policy',
          onTap: () {},
        ),
        const Divider(height: 1),
        _ListTile(
          icon: Icons.description,
          title: 'Terms of Service',
          onTap: () {},
        ),
        const SizedBox(height: AppSpacing.xxxl),
      ],
    );
  }
}

// Creation Card Widget
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

// List Tile Widget
class _ListTile extends StatelessWidget {
  const _ListTile({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: AppColors.text),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          color: AppColors.text,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.text2,
              ),
            )
          : null,
      trailing: const Icon(Icons.chevron_right, color: AppColors.text2),
      onTap: onTap,
    );
  }
}

// SliverTabBarDelegate for pinned TabBar
class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverTabBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: AppColors.surface,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverTabBarDelegate oldDelegate) {
    return false;
  }
}
