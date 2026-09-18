import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://custudbjeimtfyzeumvn.supabase.co',
    anonKey: 'sb_publishable_BBQ_V_Yeq4ZGcx5lhT8u0Q_xoUd2XUI',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Obra Livre',
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
