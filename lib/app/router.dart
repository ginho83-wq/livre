import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../services/auth_service.dart';
import '../pages/login_page.dart';
import '../pages/cadastro_page.dart';
import '../pages/home_page.dart';
import '../pages/auth_callback_page.dart';

final AuthService _authService = AuthService.instancia;

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.listen((_) {
      notifyListeners();
    });
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}

final GoRouter router = GoRouter(
  initialLocation: '/',
  refreshListenable: GoRouterRefreshStream(
    Supabase.instance.client.auth.onAuthStateChange,
  ),
  redirect: (context, state) {
    final bool autenticado = _authService.estaAutenticado;
    final String caminho = state.uri.path;

    if (!autenticado &&
        caminho != '/login' &&
        caminho != '/cadastro' &&
        caminho != '/auth/callback') {
      return '/login';
    }

    return null;
  },
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/cadastro',
      builder: (context, state) => const CadastroPage(),
    ),
    GoRoute(
      path: '/auth/callback',
      builder: (context, state) => const AuthCallbackPage(),
    ),
  ],
);

