import 'package:flutter/material.dart';

class NavigationDrawerWidget extends StatelessWidget {
  final List<Widget> children;

  const NavigationDrawerWidget({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              'MENU',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ...children,
        ],
      ),
    );
  }
}