import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'common_placeholder.dart';

Future<T?> showRoundedModalBottomSheet<T>(
        {required BuildContext context,
        required Widget Function(BuildContext context) builder,
        String? title,
        bool enableCloseButton = true,
        bool isScrollControlled = false,
        bool isDismissible = true,
        bool enableDrag = true,
        EdgeInsets margin = const EdgeInsets.symmetric(vertical: 20)}) =>
    showModalBottomSheet<T>(
        context: context,
        isDismissible: isDismissible,
        enableDrag: enableDrag,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (context) {
          final child = Container(
            margin: margin,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(children: [
                  if (title != null)
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(title,
                          style: Theme.of(context).textTheme.headline4),
                    )),
                  if (enableCloseButton)
                    IconButton(
                        iconSize: 20,
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        onPressed: () => context.popRoute(),
                        icon: const Icon(Icons.close))
                ]),
                builder.call(context),
              ],
            ),
          );

          if (isScrollControlled) {
            return SingleChildScrollView(child: child);
          } else {
            return child;
          }
        },
        isScrollControlled: isScrollControlled);

Future<T?> showAlertPlaceholder<T>(
    {required BuildContext context,
    Widget? icon,
    required String title,
    required String subtitle,
    required Widget action,
    bool dismissible = true,
    double? titleSize}) {
  return showDialog<T>(
      barrierDismissible: dismissible,
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () => Future.value(dismissible),
          child: Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 34),
                child: icon != null
                    ? CommonPlaceholder.customIcon(
                        textAlign: TextAlign.center,
                        titleSize: titleSize ?? 16,
                        icon: icon,
                        center: false,
                        title: title,
                        subtitle: subtitle,
                        action: action)
                    : CommonPlaceholder.noIcon(
                        center: false,
                        textAlign: TextAlign.center,
                        titleSize: titleSize ?? 20,
                        title: title,
                        subtitle: subtitle,
                        action: action),
              ),
            ),
          ),
        );
      });
}

Future<T?> showRoundedDialog<T>(
    {required BuildContext context,
    required Widget child,
    bool isScrollable = true,
    EdgeInsets padding = const EdgeInsets.only(top: 34),
    EdgeInsets margin = EdgeInsets.zero,
    bool dismissible = true}) {
  return showDialog<T>(
      barrierDismissible: dismissible,
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () => Future.value(dismissible),
          child: Dialog(
            insetPadding: margin,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: isScrollable
                  ? SingleChildScrollView(
                      child: Padding(
                        padding: padding,
                        child: child,
                      ),
                    )
                  : Padding(
                      padding: padding,
                      child: child,
                    ),
            ),
          ),
        );
      });
}

class CDialogCard extends StatelessWidget {
  final String title;
  final String description;
  final Widget? icon;
  final Widget? actionWidget;
  final bool dismissable;

  const CDialogCard(
      {Key? key,
      required this.title,
      required this.description,
      this.icon,
      this.actionWidget,
      this.dismissable = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 15, bottom: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: <Widget>[
                if (dismissable)
                  Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                          onPressed: () => context.router.pop(),
                          icon: const Icon(Icons.close, size: 28))),
                if (icon != null)
                  Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(
                          bottom: 28, left: 28, right: 28, top: 40),
                      child: icon),
                Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: AutoSizeText(
                    title,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  child: Text(
                    description,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          if (actionWidget != null)
            Container(
              margin: const EdgeInsets.all(20),
              child: actionWidget,
            )
        ],
      ),
    );
  }
}
