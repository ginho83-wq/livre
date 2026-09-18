import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthCallbackPage extends StatefulWidget {
  const AuthCallbackPage({
    super.key,
  });

  @override
  State<AuthCallbackPage> createState() =>
      _AuthCallbackPageState();
}

class _AuthCallbackPageState
    extends State<AuthCallbackPage> {
  String mensagem = 'A concluir o login...';

  bool _processando = true;

  @override
  void initState() {
    super.initState();

    _processarCallback();
  }

  Future<void> _processarCallback() async {
    try {
      final uri = Uri.base;

      // ==========================================================
      // VERIFICAR CODE
      // ==========================================================

      final code = uri.queryParameters['code'];

      if (code != null && code.isNotEmpty) {
        await Supabase.instance.client.auth
            .exchangeCodeForSession(code);
      }

      // ==========================================================
      // VERIFICAR SESSÃO
      // ==========================================================

      final session =
          Supabase.instance.client.auth.currentSession;

      if (session == null) {
        throw Exception(
          'Não foi possível concluir a autenticação.',
        );
      }

      if (!mounted) return;

      setState(() {
        mensagem = 'Login concluído.';
        _processando = false;
      });

      // ==========================================================
      // IR PARA HOME
      // ==========================================================

      context.go('/');
    } catch (e) {
      if (!mounted) return;

      setState(() {
        mensagem =
        'Não foi possível concluir o login.\n\n$e';
        _processando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_processando)
                const CircularProgressIndicator(),

              if (_processando)
                const SizedBox(height: 24),

              Text(
                mensagem,
                textAlign: TextAlign.center,
              ),

              if (!_processando)
                const SizedBox(height: 24),

              if (!_processando)
                TextButton(
                  onPressed: () {
                    context.go('/login');
                  },
                  child: const Text(
                    'Voltar ao login',
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
