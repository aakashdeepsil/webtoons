import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:supabase_auth_ui/supabase_auth_ui.dart';

import 'package:webtoons/authentication/email_authentication.dart';
import 'package:webtoons/constants.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Sign In'),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          EmailAuth(
            redirectTo: kIsWeb ? null : 'io.supabase.flutter://',
            onSignInComplete: (response) {
              Navigator.of(context).pushReplacementNamed('/home');
            },
            onSignUpComplete: (response) async {
              Navigator.of(context).pushReplacementNamed('/home');

              await supabase.from('USER').insert({
                'email_address': response.user!.email,
                'first_name': '',
                'last_name': '',
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
            socialButtonVariant: SocialButtonVariant.icon,
            socialProviders: const [
              OAuthProvider.facebook,
              OAuthProvider.google,
              OAuthProvider.twitter,
            ],
            onSuccess: (session) async {
              Navigator.of(context).pushReplacementNamed('/home');

              final emailAddress = session.user.email;

              final checkUser = await supabase
                  .from('USER')
                  .select()
                  .eq('email_address', emailAddress!);

              if (checkUser.isEmpty) {
                await supabase.from('USER').insert({
                  'email_address': session.user.email,
                  'first_name': '',
                  'last_name': '',
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
