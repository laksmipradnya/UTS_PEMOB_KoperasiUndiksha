import 'package:flutter/material.dart';
import 'package:layout2/pages/profil_page.dart';
import 'package:layout2/pages/setting_page.dart';

class BottomMenu extends StatelessWidget {
  const BottomMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      color: const Color.fromARGB(255, 188, 203, 227),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.settings, color: Colors.blue[900]),
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const SettingPage()));
              },
            ),
            IconButton(
              icon: Icon(Icons.person, color: Colors.blue[900]),
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfilPage()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
