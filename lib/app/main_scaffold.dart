import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/app_spacing.dart';

/// Main scaffold with bottom navigation
class MainScaffold extends StatefulWidget {
  const MainScaffold({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/my');
        break;
      case 2:
        context.go('/account');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Determine current index from route
    final location = GoRouterState.of(context).uri.toString();
    if (location == '/') {
      _currentIndex = 0;
    } else if (location == '/my') {
      _currentIndex = 1;
    } else if (location == '/account') {
      _currentIndex = 2;
    }

    return Scaffold(
      body: widget.child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border(
            top: BorderSide(
              color: AppColors.stroke,
              width: 1,
            ),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.xs,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavItem(
                  icon: Icons.home_rounded,
                  label: 'Home',
                  isSelected: _currentIndex == 0,
                  onTap: () => _onItemTapped(0),
                ),
                _NavItem(
                  icon: Icons.photo_library_rounded,
                  label: 'My',
                  isSelected: _currentIndex == 1,
                  onTap: () => _onItemTapped(1),
                ),
                _NavItem(
                  icon: Icons.person_rounded,
                  label: 'Account',
                  isSelected: _currentIndex == 2,
                  onTap: () => _onItemTapped(2),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton.extended(
              onPressed: () {
                // Scroll to templates section or show template picker
              },
              backgroundColor: AppColors.lime,
              foregroundColor: AppColors.bg,
              icon: const Icon(Icons.auto_awesome),
              label: const Text('Create'),
              elevation: 8,
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.lime : AppColors.text2,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? AppColors.lime : AppColors.text2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
