import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

import 'package:webtoons/authentication/email_authentication.dart';
import 'package:webtoons/constants.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Sign In'),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          EmailAuth(
            // redirectTo: kIsWeb ? null : 'yourScheme://yourDomain.com',
            redirectTo: kIsWeb ? null : 'io.supabase.webtoons://',
            onSignInComplete: (response) {},
            onSignUpComplete: (response) async {
              context.go('/home');

              await supabase.from('profiles').insert({
                'email_address': response.user!.email,
                'username': response.user!.userMetadata?['username'],
              });
            },
            dataFields: [
              DataField(
                prefixIcon: const Icon(Icons.person),
                label: 'Username',
                key: 'username',
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Please enter a unique username';
                  }
                  return null;
                },
              ),
            ],
          ),
          const Divider(),
          spacer(12),
          SupaSocialsAuth(
            colored: true,
            nativeGoogleAuthConfig: const NativeGoogleAuthConfig(
              webClientId:
                  '1041085987882-tf1dca8vbnv5ect9gqljupdpgr5iaqbp.apps.googleusercontent.com',
              iosClientId:
                  '1041085987882-jt7g00fbtaq13uckto4ti6nrvrunks9o.apps.googleusercontent.com',
            ),
            enableNativeAppleAuth: false,
            socialProviders: const [OAuthProvider.google],
            onSuccess: (session) async {
              context.go('/home');

              final emailAddress = session.user.email;

              final checkUser = await supabase
                  .from('profiles')
                  .select()
                  .eq('email_address', emailAddress!);

              if (checkUser.isEmpty) {
                await supabase.from('profiles').insert({
                  'email_address': session.user.email,
                  'username': session.user.email,
                });
              }
            },
          ),
        ],
      ),
    );
  }
}
