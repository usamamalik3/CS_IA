import 'package:cs_ia/screens/Orderhistory.dart';
import 'package:cs_ia/screens/home.dart';
import 'package:cs_ia/screens/login.dart';
import 'package:cs_ia/screens/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class navigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            createDrawerBodyItem(
              icon: Icons.home,
              text: 'Home',
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Home())),
            ),
            createDrawerBodyItem(
              icon: Icons.cabin_outlined,
              text: 'Order history',
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfileScreen())),
            ),
            createDrawerBodyItem(
                icon: Icons.account_circle,
                text: 'Logout',
                onTap: () async {
                  await _auth.signOut();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Login()));
                }),
            const ListTile(
              title: Text(
                'App version 1.0.0',
                style: TextStyle(
                  fontFamily: 'Roboto-Thin',
                  color: Color(0xff8f53ea),
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  createDrawerBodyItem(
      {IconData? icon,
      String? text,
      required Future<Object?> Function() onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(
            icon,
            color: const Color(0xff8f53ea),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              text!,
              style: const TextStyle(
                fontFamily: 'Roboto-Thin',
                color: Color(0xff8f53ea),
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
