import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  AuthService._();
  static final AuthService instancia = AuthService._();

  final SupabaseClient _client = Supabase.instance.client;

  bool get estaAutenticado => _client.auth.currentSession != null;

  Future<void> login(String email, String senha) async {
    await _client.auth.signInWithPassword(email: email, password: senha);
  }

  Future<void> cadastro(String email, String senha) async {
    await _client.auth.signUp(email: email, password: senha);
  }

  Future<void> logout() async {
    await _client.auth.signOut();
  }
}
