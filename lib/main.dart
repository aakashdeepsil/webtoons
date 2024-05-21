import 'package:flutter/material.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

import 'package:webtoons/authentication/sign_in.dart';
import 'package:webtoons/authentication/update_password.dart';
import 'package:webtoons/home.dart';
import 'package:webtoons/theme/theme_provider.dart';

Future<void> main() async {
  await dotenv.load();

  await Supabase.initialize(
    url: dotenv.get('SUPABASE_URL'),
    anonKey: dotenv.get('SUPABASE_ANON_KEY'),
  );

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WebToons',
      theme: Provider.of<ThemeProvider>(context).themeData,
      initialRoute: '/',
      routes: {
        '/': (context) => const SignUp(),
        '/update_password': (context) => const UpdatePassword(),
        '/home': (context) => const Home(),
      },
      onUnknownRoute: (RouteSettings settings) {
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (BuildContext context) => const Scaffold(
            body: Center(
              child: Text(
                'Not Found',
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
