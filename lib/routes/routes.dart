import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:webtoons/authentication/auth.dart';
import 'package:webtoons/authentication/update_password.dart';
import 'package:webtoons/home.dart';
import 'package:webtoons/profile/edit_profile.dart';
import 'package:webtoons/profile/profile.dart';

List<RouteBase> routes = [
  GoRoute(
    path: 'sign_in',
    builder: (BuildContext context, GoRouterState state) {
      return const AuthenticationPage();
    },
  ),
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
    routes: <RouteBase>[
      GoRoute(
        path: 'edit_profile',
        builder: (BuildContext context, GoRouterState state) {
          return const EditProfilePage();
        },
      ),
    ],
  ),
];