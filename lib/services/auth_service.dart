import 'dart:async';

import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  AuthService._();

  static final AuthService instancia = AuthService._();

  final SupabaseClient _supabase = Supabase.instance.client;

  User? get usuarioAtual => _supabase.auth.currentUser;

  bool get estaAutenticado => usuarioAtual != null;

  Stream<AuthState> get eventosAuth =>
      _supabase.auth.onAuthStateChange;

  Future<bool> entrarComGoogle() async {
    try {
      return await _supabase.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo:
        'https://ginho83-wq.github.io/livre/auth/callback',
      );
    } catch (e) {
      return false;
    }
  }

  Future<void> sair() async {
    await _supabase.auth.signOut();
  }
}

