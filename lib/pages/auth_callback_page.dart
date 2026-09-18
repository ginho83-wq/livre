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

  @override
  void initState() {
    super.initState();
    _verificarLogin();
  }

  Future<void> _verificarLogin() async {
    await Future.delayed(
      const Duration(milliseconds: 500),
    );

    if (!mounted) return;

    final session =
        Supabase.instance.client.auth.currentSession;

    if (session != null) {
      context.go('/');
    } else {
      setState(() {
        mensagem =
        'Não foi possível concluir o login.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 24),
            Text(mensagem),
            const SizedBox(height: 24),
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
    );
  }
}

