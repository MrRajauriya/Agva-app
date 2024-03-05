import 'package:flutter/material.dart';

class Drawer extends StatelessWidget {
  const Drawer({
    super.key, required ListView child,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        physics: BouncingScrollPhysics(),
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
                // color: Colors.white,
                ),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'AgVa',
                style: TextStyle(
                  color: Color.fromARGB(255, 157, 0, 86),
                  fontSize: 50,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: Colors.white),
            title: Text(
              'HOME',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.person, color: Colors.white),
            title: Text(
              'PROFILE',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.devices_other, color: Colors.white),
            title: Text(
              'DEVICES',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.circle, color: Colors.white),
            title: Text(
              'LIVE',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.settings, color: Colors.white),
            title: Text(
              'SETTINGS',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
              ),
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}