import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../data/providers/balance_provider.dart';

class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final balanceAsync = ref.watch(balanceProvider);

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: CustomScrollView(
        slivers: [
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
          SliverList(
            delegate: SliverChildListDelegate([
              const SizedBox(height: AppSpacing.md),
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
                  'Settings',
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
            ]),
          ),
        ],
      ),
    );
  }
}

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
