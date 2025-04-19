import 'package:flutter/material.dart';
import 'package:forkify_app/data/data_notifier.dart';

class NavnarWidget extends StatelessWidget {
  const NavnarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedPageNotifier,
      builder: (context, pageSelected, child) {
        return NavigationBar(
          destinations: [
            NavigationDestination(
              tooltip: 'Home',
              icon: Icon(Icons.home_filled),
              label: 'Home',
            ),
            NavigationDestination(
              tooltip: 'Regiter a Recipe',
              icon: Icon(Icons.app_registration_rounded),
              label: 'Add Recipe',
            ),
            NavigationDestination(
              tooltip: 'Bookmard a Recipe',
              icon: Icon(Icons.bookmark_border),
              label: 'Bookmark',
            ),
          ],
          onDestinationSelected: (value) {
            selectedPageNotifier.value = value;
          },
          selectedIndex: pageSelected,
        );
      },
    );
  }
}
