import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

import 'package:webtoons/constants.dart';

class UpdatePassword extends StatelessWidget {
  const UpdatePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Update Password'),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            SupaResetPassword(
              accessToken: supabase.auth.currentSession?.accessToken,
              onSuccess: (response) {
                context.go('/home');
              },
            ),
            TextButton(
              child: const Text(
                'Take me back to Sign Up',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () => context.go('/'),
            ),
          ],
        ),
      ),
    );
  }
}
