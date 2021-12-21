import 'package:flutter/material.dart';

class ActionListTile extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final Widget? icon;
  const ActionListTile({Key? key, required this.title, this.onTap, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).indicatorColor),
          borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 6, horizontal: 15.62),
        leading: icon,
        title: Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).textTheme.headline1!.color),
        ),
        onTap: onTap,
        trailing: const Icon(
          Icons.chevron_right,
          size: 20,
        ),
      ),
    );
  }
}

class SettingListTile extends StatelessWidget {
  final String title;
  final IconData? icon;
  final VoidCallback? onTap;

  const SettingListTile({Key? key, required this.title, this.icon, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon != null ? Icon(icon) : null,
      horizontalTitleGap: 0,
      title: Text(
        title,
        style: TextStyle(
            fontSize: 12, color: Theme.of(context).textTheme.headline1!.color),
      ),
      trailing: const Icon(
        Icons.chevron_right,
        size: 20,
      ),
      onTap: onTap,
    );
  }
}
