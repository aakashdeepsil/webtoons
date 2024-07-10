import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

import 'package:webtoons/constants.dart';

class ProfileSettingsPage extends StatefulWidget {
  const ProfileSettingsPage({super.key});

  @override
  State<ProfileSettingsPage> createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('Profile Settings', automaticallyImplyLeading: true),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            ListTile(
              title: const Text('Edit Profile Information'),
              onTap: () {
                GoRouter.of(context).go('profile/edit_profile');
              },
            ),
            ListTile(
              title: const Text('Update Password'),
              onTap: () {
                GoRouter.of(context).go('profile/update_password');
              },
            ),
            ListTile(
              title: const Text('Log Out'),
              onTap: () {
                Supabase.instance.client.auth.signOut();
                context.go('/');
              },
            ),
          ],
        )),
      ),
    );
  }
}
