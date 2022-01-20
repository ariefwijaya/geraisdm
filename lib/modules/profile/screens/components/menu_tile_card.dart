import 'package:flutter/material.dart';

class MenuTileCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;
  const MenuTileCard(
      {Key? key, required this.title, required this.icon, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            icon,
            size: 30,
          ),
          title: Text(
            title,
          ),
          trailing: onTap != null ? const Icon(Icons.chevron_right) : null,
          onTap: onTap,
        ),
        Divider(thickness: 1, color: Theme.of(context).highlightColor)
      ],
    );
  }
}
