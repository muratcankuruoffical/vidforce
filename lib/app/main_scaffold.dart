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
    } else if (location == '/account' || location.startsWith('/account')) {
      _currentIndex = 1;
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
          child: SizedBox(
            height: 80,
            child: Stack(
              children: [
                // Regular navigation items
                Row(
                  children: [
                    Expanded(
                      child: _NavItem(
                        icon: Icons.home_rounded,
                        label: 'Home',
                        isSelected: _currentIndex == 0,
                        onTap: () => _onItemTapped(0),
                      ),
                    ),
                    const SizedBox(width: 100), // Space for Create button
                    Expanded(
                      child: _NavItem(
                        icon: Icons.person_rounded,
                        label: 'Account',
                        isSelected: _currentIndex == 1,
                        onTap: () => _onItemTapped(1),
                      ),
                    ),
                  ],
                ),
                // Elevated Create button in center
                Positioned(
                  left: MediaQuery.of(context).size.width / 2 - 32,
                  top: 8,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.lime.withOpacity(0.3),
                          blurRadius: 20,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Material(
                      color: AppColors.lime,
                      shape: const CircleBorder(),
                      child: InkWell(
                        onTap: () {
                          // Show template picker or scroll to templates
                          if (_currentIndex == 0) {
                            // Already on home, could scroll to templates section
                          } else {
                            context.go('/');
                          }
                        },
                        customBorder: const CircleBorder(),
                        child: Container(
                          width: 64,
                          height: 64,
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.auto_awesome_rounded,
                            color: AppColors.bg,
                            size: 32,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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
