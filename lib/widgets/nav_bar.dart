import 'package:flutter/material.dart';

class NavBarCustom extends StatelessWidget {
  const NavBarCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return NavigationBar(destinations: const [
      NavigationDestination(icon: Icon(Icons.home_rounded), label: 'Home'),
      NavigationDestination(icon: Icon(Icons.bookmark_rounded), label: 'Saved')
    ]);
  }
}
