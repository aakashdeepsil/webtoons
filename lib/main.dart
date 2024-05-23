import 'package:flutter/material.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:webtoons/authentication/sign_in.dart';
import 'package:webtoons/authentication/update_password.dart';
import 'package:webtoons/home.dart';
import 'package:webtoons/profile/profile.dart';
import 'package:webtoons/theme/theme_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

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

final GoRouter _router = GoRouter(
  // errorBuilder: (context, state) => ErrorScreen(state.error),
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const SignUp();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'home',
          builder: (BuildContext context, GoRouterState state) {
            return const Home();
          },
        ),
        GoRoute(
          path: 'update_password',
          builder: (BuildContext context, GoRouterState state) {
            return const UpdatePassword();
          },
        ),
        GoRoute(
          path: 'profile',
          builder: (BuildContext context, GoRouterState state) {
            return const ProfilePage();
          },
        ),
      ],
    ),
  ],
);

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      theme: Provider.of<ThemeProvider>(context).themeData,
      title: 'WebToons',
    );
  }
}
