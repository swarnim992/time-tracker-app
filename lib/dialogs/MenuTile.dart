



import 'package:flutter/material.dart';

class MenuTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function() ontab;
  const MenuTile({super.key, required this.title, required this.icon, required this.ontab});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: Icon(
          icon,
          size: 35,
          color: Colors.black,
        ),
        title: Text(title,style: TextStyle(
          fontSize: 18,
          color: Colors.black
        ),
        ),
        onTap: ontab,
    );
  }
}
