import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/onboarding/onboarding_screen.dart';
import '../features/home/home_screen.dart';
import '../features/template_detail/template_detail_screen.dart';
import '../features/generate/generate_screen.dart';
import '../features/generate/result_viewer_screen.dart';
import '../features/my_creations/my_creations_screen.dart';
import '../features/account/account_screen.dart';
import '../features/credits/credit_packs_screen.dart';
import 'main_scaffold.dart';

/// Application routes
class AppRoutes {
  static const String onboarding = '/onboarding';
  static const String home = '/';
  static const String templateDetail = '/template/:id';
  static const String generate = '/generate/:id';
  static const String result = '/result/:id';
  static const String myCreations = '/my';
  static const String account = '/account';
  static const String creditPacks = '/account/credits';
}

/// Router configuration
final goRouter = GoRouter(
  initialLocation: AppRoutes.onboarding,
  routes: [
    GoRoute(
      path: AppRoutes.onboarding,
      builder: (context, state) => const OnboardingScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) => MainScaffold(child: child),
      routes: [
        GoRoute(
          path: AppRoutes.home,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: HomeScreen(),
          ),
        ),
        GoRoute(
          path: AppRoutes.myCreations,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: MyCreationsScreen(),
          ),
        ),
        GoRoute(
          path: AppRoutes.account,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: AccountScreen(),
          ),
        ),
      ],
    ),
    GoRoute(
      path: '/template/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return TemplateDetailScreen(templateId: id);
      },
    ),
    GoRoute(
      path: '/generate/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return GenerateScreen(templateId: id);
      },
    ),
    GoRoute(
      path: '/result/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return ResultViewerScreen(creationId: id);
      },
    ),
    GoRoute(
      path: AppRoutes.creditPacks,
      builder: (context, state) => const CreditPacksScreen(),
    ),
  ],
);
