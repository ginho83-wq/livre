import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  AuthService._();

  static final AuthService instancia =
  AuthService._();

  final SupabaseClient _supabase =
      Supabase.instance.client;

  // ============================================================
  // USUÁRIO ATUAL
  // ============================================================

  User? get usuarioAtual {
    return _supabase.auth.currentUser;
  }

  // ============================================================
  // EVENTOS DE AUTENTICAÇÃO
  // ============================================================

  Stream<AuthState> get eventosAuth {
    return _supabase.auth.onAuthStateChange;
  }

  // ============================================================
  // LOGIN EMAIL
  // ============================================================

  Future<void> entrarComEmail({
    required String email,
    required String senha,
  }) async {
    await _supabase.auth.signInWithPassword(
      email: email.trim(),
      password: senha,
    );
  }

  // ============================================================
  // CRIAR CONTA
  // ============================================================

  Future<void> criarConta({
    required String email,
    required String senha,
  }) async {
    await _supabase.auth.signUp(
      email: email.trim(),
      password: senha,
      emailRedirectTo:
      '${Uri.base.origin}/livre/auth/callback',
    );
  }

  // ============================================================
  // LOGIN GOOGLE
  // ============================================================

  Future<void> entrarComGoogle() async {
    final redirectUrl =
        '${Uri.base.origin}/livre/auth/callback';

    await _supabase.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectTo: redirectUrl,
    );
  }

  // ============================================================
  // SAIR
  // ============================================================

  Future<void> sair() async {
    await _supabase.auth.signOut();
  }
}
