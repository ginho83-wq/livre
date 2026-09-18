import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../pages/auth_callback_page.dart';
import '../pages/cadastro_page.dart';
import '../pages/home_page.dart';
import '../pages/login_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',

  refreshListenable: GoRouterRefreshStream(
    Supabase.instance.client.auth.onAuthStateChange,
  ),

  redirect: (context, state) {
    final session =
        Supabase.instance.client.auth.currentSession;

    final location = state.matchedLocation;

    final estaNoLogin = location == '/login';
    final estaNoCadastro = location == '/cadastro';
    final estaNoCallback = location == '/auth/callback';

    // ============================================================
    // CALLBACK
    // ============================================================

    if (estaNoCallback) {
      return null;
    }

    // ============================================================
    // NÃO AUTENTICADO
    // ============================================================

    if (session == null) {
      if (estaNoLogin ||
          estaNoCadastro ||
          estaNoCallback) {
        return null;
      }

      return '/login';
    }

    // ============================================================
    // AUTENTICADO
    // ============================================================

    if (estaNoLogin || estaNoCadastro) {
      return '/';
    }

    return null;
  },

  routes: [
    // ============================================================
    // LOGIN
    // ============================================================

    GoRoute(
      path: '/login',
      builder: (context, state) {
        return const LoginPage();
      },
    ),

    // ============================================================
    // CADASTRO
    // ============================================================

    GoRoute(
      path: '/cadastro',
      builder: (context, state) {
        return const CadastroPage();
      },
    ),

    // ============================================================
    // CALLBACK SUPABASE
    // ============================================================

    GoRoute(
      path: '/auth/callback',
      builder: (context, state) {
        return const AuthCallbackPage();
      },
    ),

    // ============================================================
    // HOME
    // ============================================================

    GoRoute(
      path: '/',
      builder: (context, state) {
        return const HomePage();
      },
    ),

    // ============================================================
    // HOME ALTERNATIVA
    // ============================================================

    GoRoute(
      path: '/home',
      builder: (context, state) {
        return const HomePage();
      },
    ),
  ],
);

class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    _subscription = stream.listen(
          (_) {
        notifyListeners();
      },
    );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
