import 'package:flutter/material.dart';
import 'package:geraisdm/widgets/button_component.dart';
import 'package:geraisdm/constant/localizations.g.dart';
import 'package:easy_localization/easy_localization.dart';

class HomeTitleDivider extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  const HomeTitleDivider(
      {Key? key, required this.title, this.subtitle, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headline4,
              ),
              if (subtitle != null) const SizedBox(height: 5),
              if (subtitle != null)
                Text(
                  subtitle!,
                )
            ],
          ),
        ),
        if (onTap != null) const SizedBox(width: 8),
        if (onTap != null)
          NudeButton.small(
              infiniteWidth: false,
              buttonText: LocaleKeys.home_menu_more.tr(),
              onPressed: onTap!)
      ],
    );
  }
}
