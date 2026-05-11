import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/routes/screens/routes_screen.dart';
import '../features/routes/screens/route_detail_screen.dart';
import '../features/favorites/screens/favorites_screen.dart';
import '../features/settings/screens/settings_screen.dart';
import '../core/widgets/adaptive_scaffold.dart';

final router = GoRouter(
  initialLocation: '/login',
  redirect: (context, state) {
    // Импортируем провайдер из правильного места
    final isLoggedIn = ProviderScope.containerOf(context).read(isLoggedInProvider);
    final isLoginRoute = state.matchedLocation == '/login';
    
    if (!isLoggedIn && !isLoginRoute) {
      return '/login';
    }
    if (isLoggedIn && isLoginRoute) {
      return '/';
    }
    return null;
  },
  routes: [
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const AdaptiveScaffold(
        child: RoutesScreen(),
      ),
    ),
    GoRoute(
      path: '/route/:id',
      name: 'route_detail',
      builder: (context, state) => RouteDetailScreen(
        routeId: int.parse(state.pathParameters['id']!),
      ),
    ),
    GoRoute(
      path: '/favorites',
      name: 'favorites',
      builder: (context, state) => const AdaptiveScaffold(
        child: FavoritesScreen(),
      ),
    ),
    GoRoute(
      path: '/settings',
      name: 'settings',
      builder: (context, state) => const AdaptiveScaffold(
        child: SettingsScreen(),
      ),
    ),
  ],
);
