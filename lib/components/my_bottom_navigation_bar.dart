import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

class MyBottomNavigationBar extends StatelessWidget {
  const MyBottomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(15.0),
        topRight: Radius.circular(15.0),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 3,
        backgroundColor: Theme.of(context).colorScheme.surface,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.home),
            label: 'Home',
            tooltip: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.search),
            label: 'Explore',
            tooltip: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.library),
            label: 'Library',
            tooltip: 'Library',
          ),
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.userCircle),
            label: 'Profile',
            tooltip: 'Profile',
          ),
        ],
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.onSurface,
        onTap: (value) {
          switch (value) {
            case 0:
              context.go('/home');
              break;
            case 1:
              break;
            case 2:
              break;
            case 3:
              context.go('/profile');
              break;
            default:
              break;
          }
        },
      ),
    );
  }
}
