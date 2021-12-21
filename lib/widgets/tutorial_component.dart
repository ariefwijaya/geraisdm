import '../../../../constant/localizations.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

import 'button_component.dart';

class TutorialComponent extends StatelessWidget {
  final GlobalKey tutorialKey;
  final Widget child;
  final Widget? icon;
  final String description;
  final ShapeBorder? shapeBorder;
  final VoidCallback? onTapAction;

  const TutorialComponent(
      {Key? key,
      required this.tutorialKey,
      required this.child,
      required this.description,
      this.shapeBorder,
      this.icon,
      this.onTapAction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Showcase.withWidget(
      key: tutorialKey,
      contentPadding: const EdgeInsets.symmetric(horizontal: 19, vertical: 19),
      overlayPadding: const EdgeInsets.all(8),
      shapeBorder: shapeBorder ??
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      container: Container(
        width: MediaQuery.of(context).size.width - 30,
        margin: const EdgeInsets.symmetric(horizontal: 26),
        padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 17),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (icon != null) icon!,
            if (icon != null)
              const SizedBox(
                width: 12,
              ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  NudeButton.small(
                      buttonText: LocaleKeys.tutorial_action_next.tr(),
                      infiniteWidth: false,
                      onPressed: () {
                        ShowCaseWidget.of(context)!.completed(tutorialKey);
                        onTapAction?.call();
                      }),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                ShowCaseWidget.of(context)!.dismiss();
              },
              icon: const Icon(
                Icons.close,
                size: 20,
              ),
            ),
          ],
        ),
      ),
      child: child,
    );
  }
}
