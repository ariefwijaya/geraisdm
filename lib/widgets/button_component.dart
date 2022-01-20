import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

/// Base class for filled button
/// that will be reused by class [FilledButton] in a static method
class _FilledButtonBuilder extends StatelessWidget {
  const _FilledButtonBuilder(
      {Key? key,
      required this.buttonText,
      required this.infiniteWidth,
      this.onPressed,
      this.height,
      this.padding,
      this.enabled = true,
      this.useElevation = false,
      this.isLoading = false,
      this.backgroundColor,
      this.suffixIcon})
      : super(key: key);

  final String buttonText;
  final VoidCallback? onPressed;
  final double? height;
  final bool infiniteWidth;
  final bool enabled;
  final bool useElevation;
  final bool isLoading;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          padding: padding != null ? MaterialStateProperty.all(padding) : null,
          backgroundColor: MaterialStateProperty.resolveWith((states) =>
              states.contains(MaterialState.disabled)
                  ? backgroundColor?.withOpacity(0.4) ??
                      Theme.of(context).disabledColor
                  : backgroundColor ?? Theme.of(context).primaryColor),
          elevation: MaterialStateProperty.resolveWith((states) =>
              states.contains(MaterialState.disabled)
                  ? 0
                  : (useElevation ? 8 : 0)),
          minimumSize: height != null
              ? MaterialStateProperty.all(
                  infiniteWidth ? Size.fromHeight(height!) : Size(96, height!))
              : null),
      onPressed: enabled && !isLoading ? onPressed : null,
      child: isLoading
          ? CircularProgressIndicator(
              color: Theme.of(context).scaffoldBackgroundColor,
            )
          : suffixIcon != null
              ? Row(
                  children: [
                    Expanded(
                        child: Text(
                      buttonText,
                      textAlign: TextAlign.center,
                    )),
                    if (suffixIcon != null) suffixIcon!
                  ],
                )
              : Text(buttonText),
    );
  }
}

/// Filled button wrapper to build spesific button type within Filled Button.
/// Please refer to components page in Figma Design
class FilledButton {
  FilledButton._();

  /// return FilledButton in a Large size
  static Widget large(
      {Key? key,
      required String buttonText,
      required VoidCallback onPressed,
      bool infiniteWidth = true,
      bool enabled = true,
      bool useElevation = false,
      bool isLoading = false,
      Color? backgroundColor,
      Widget? suffixIcon,
      EdgeInsets? padding}) {
    return _FilledButtonBuilder(
        buttonText: buttonText,
        onPressed: onPressed,
        height: 52,
        infiniteWidth: infiniteWidth,
        enabled: enabled,
        useElevation: useElevation,
        isLoading: isLoading,
        backgroundColor: backgroundColor,
        padding: padding,
        suffixIcon: suffixIcon);
  }

  /// return FilledButton in a Medium size
  static Widget medium(
      {Key? key,
      required String buttonText,
      required VoidCallback onPressed,
      bool infiniteWidth = true,
      bool enabled = true,
      bool useElevation = false,
      bool isLoading = false,
      Color? backgroundColor,
      EdgeInsets? padding}) {
    return _FilledButtonBuilder(
      buttonText: buttonText,
      onPressed: onPressed,
      height: 40,
      infiniteWidth: infiniteWidth,
      enabled: enabled,
      useElevation: useElevation,
      isLoading: isLoading,
      backgroundColor: backgroundColor,
      padding: padding,
    );
  }

  /// return FilledButton in a Small size
  static Widget small(
      {Key? key,
      required String buttonText,
      required VoidCallback onPressed,
      bool infiniteWidth = true,
      bool enabled = true,
      bool useElevation = false,
      bool isLoading = false,
      Color? backgroundColor,
      EdgeInsets? padding}) {
    return _FilledButtonBuilder(
        buttonText: buttonText,
        onPressed: onPressed,
        height: 28,
        infiniteWidth: infiniteWidth,
        enabled: enabled,
        useElevation: useElevation,
        isLoading: isLoading,
        padding: padding,
        backgroundColor: backgroundColor);
  }
}

/// Base class for Ghost button
/// that will be reused by class [GhostButton] in a static method
class _GhostButtonBuilder extends StatelessWidget {
  const _GhostButtonBuilder(
      {Key? key,
      required this.buttonText,
      required this.infiniteWidth,
      this.onPressed,
      this.height,
      this.enabled = true,
      this.color,
      this.textColor,
      this.borderRadius = 12})
      : super(key: key);

  final String buttonText;
  final VoidCallback? onPressed;
  final double? height;
  final bool infiniteWidth;
  final bool enabled;
  final Color? color;
  final Color? textColor;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: enabled ? onPressed : null,
      style: ButtonStyle(
          side: MaterialStateProperty.resolveWith((states) =>
              (states.contains(MaterialState.disabled))
                  ? BorderSide(color: Theme.of(context).disabledColor)
                  : BorderSide(color: color ?? Theme.of(context).primaryColor)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius))),
          minimumSize: height != null
              ? MaterialStateProperty.all(
                  infiniteWidth ? Size.fromHeight(height!) : Size(30, height!))
              : null),
      child: Text(
        buttonText,
        style: TextStyle(color: textColor ?? Theme.of(context).primaryColor),
      ),
    );
  }
}

/// Ghost Button wrapper to build spesific button type within Ghost Button.
/// Please refer to components page in Figma Design
class GhostButton {
  GhostButton._();

  /// return GhostButton in a Large size
  static Widget large(
      {Key? key,
      required String buttonText,
      required VoidCallback onPressed,
      bool infiniteWidth = true,
      bool enabled = true,
      Color? color,
      Color? textColor,
      double borderRadius = 12}) {
    return _GhostButtonBuilder(
      buttonText: buttonText,
      onPressed: onPressed,
      height: 52,
      infiniteWidth: infiniteWidth,
      enabled: enabled,
      color: color,
      textColor: textColor,
      borderRadius: borderRadius,
    );
  }

  /// return GhostButton in a Medium size
  static Widget medium(
      {Key? key,
      required String buttonText,
      required VoidCallback onPressed,
      bool infiniteWidth = true,
      bool enabled = true,
      Color? color,
      Color? textColor,
      double borderRadius = 12}) {
    return _GhostButtonBuilder(
      buttonText: buttonText,
      onPressed: onPressed,
      height: 40,
      infiniteWidth: infiniteWidth,
      enabled: enabled,
      color: color,
      textColor: textColor,
      borderRadius: borderRadius,
    );
  }

  /// return GhostButton in a Small size
  static Widget small(
      {Key? key,
      required String buttonText,
      required VoidCallback onPressed,
      bool infiniteWidth = true,
      bool enabled = true,
      Color? color,
      Color? textColor,
      double borderRadius = 12}) {
    return _GhostButtonBuilder(
      buttonText: buttonText,
      onPressed: onPressed,
      height: 28,
      infiniteWidth: infiniteWidth,
      enabled: enabled,
      color: color,
      textColor: textColor,
      borderRadius: borderRadius,
    );
  }
}

/// Base class for Ghost button
/// that will be reused by class [GhostButton] in a static method
class _NudeButtonBuilder extends StatelessWidget {
  const _NudeButtonBuilder(
      {Key? key,
      required this.buttonText,
      required this.infiniteWidth,
      this.onPressed,
      this.height,
      this.enabled = true,
      this.color,
      this.icon,
      this.isLoading = false})
      : super(key: key);

  final String buttonText;
  final VoidCallback? onPressed;
  final double? height;
  final bool infiniteWidth;
  final bool enabled;
  final Color? color;
  final Widget? icon;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final buttonStyle = ButtonStyle(
        foregroundColor:
            color != null ? MaterialStateProperty.all(color) : null,
        minimumSize: height != null
            ? MaterialStateProperty.all(
                infiniteWidth ? Size.fromHeight(height!) : Size(30, height!))
            : null);

    final myonPressed = enabled && !isLoading ? onPressed : null;
    final child = isLoading
        ? CircularProgressIndicator(
            color: color,
          )
        : Text(buttonText);

    if (icon != null && !isLoading) {
      return TextButton.icon(
        onPressed: onPressed,
        icon: icon!,
        label: child,
        style: buttonStyle,
      );
    }
    return TextButton(
      style: buttonStyle,
      onPressed: myonPressed,
      child: child,
    );
  }
}

/// Nude Button wrapper to build spesific button type within Nude Button.
/// Please refer to components page in Figma Design
class NudeButton {
  NudeButton._();

  /// return NudeButton in a Large size
  static Widget large(
      {Key? key,
      required String buttonText,
      required VoidCallback onPressed,
      bool infiniteWidth = true,
      bool enabled = true,
      bool isLoading = false,
      Color? color}) {
    return _NudeButtonBuilder(
      buttonText: buttonText,
      onPressed: onPressed,
      height: 52,
      infiniteWidth: infiniteWidth,
      enabled: enabled,
      color: color,
      isLoading: isLoading,
    );
  }

  /// return NudeButton in a Medium size
  static Widget medium(
      {Key? key,
      required String buttonText,
      required VoidCallback onPressed,
      bool infiniteWidth = true,
      bool enabled = true,
      Color? color,
      bool isLoading = false}) {
    return _NudeButtonBuilder(
      buttonText: buttonText,
      onPressed: onPressed,
      height: 40,
      infiniteWidth: infiniteWidth,
      enabled: enabled,
      color: color,
      isLoading: isLoading,
    );
  }

  /// return NudeButton in a Small size
  static Widget small(
      {Key? key,
      required String buttonText,
      required VoidCallback onPressed,
      bool infiniteWidth = true,
      bool enabled = true,
      Color? color,
      Icon? icon,
      bool isLoading = false}) {
    return _NudeButtonBuilder(
      buttonText: buttonText,
      onPressed: onPressed,
      height: 28,
      infiniteWidth: infiniteWidth,
      enabled: enabled,
      color: color,
      icon: icon,
      isLoading: isLoading,
    );
  }
}

class SocialButton extends StatelessWidget {
  const SocialButton(
      {Key? key,
      required this.buttonText,
      required this.infiniteWidth,
      this.onPressed,
      this.height = 52,
      this.enabled = true,
      this.useElevation = false,
      required this.iconAssetPath,
      this.foreground,
      this.background})
      : super(key: key);

  final String buttonText;
  final VoidCallback? onPressed;
  final double? height;
  final bool infiniteWidth;
  final bool enabled;
  final bool useElevation;
  final String iconAssetPath;
  final Color? background;
  final Color? foreground;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      icon: Container(
        width: 25,
        height: 25,
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(iconAssetPath))),
      ),
      onPressed: enabled ? onPressed : null,
      style: ButtonStyle(
          side: MaterialStateProperty.all<BorderSide>(
              BorderSide(color: Theme.of(context).indicatorColor)),
          backgroundColor: MaterialStateProperty.resolveWith((states) => states.contains(MaterialState.disabled)
              ? background ?? Theme.of(context).dividerColor.withOpacity(0.05)
              : background ?? Theme.of(context).scaffoldBackgroundColor),
          foregroundColor: MaterialStateProperty.resolveWith((states) =>
              states.contains(MaterialState.disabled)
                  ? foreground ??
                      Theme.of(context).selectedRowColor.withOpacity(0.3)
                  : foreground ?? Theme.of(context).selectedRowColor),
          elevation: MaterialStateProperty.resolveWith((states) =>
              states.contains(MaterialState.disabled)
                  ? 0
                  : (useElevation ? 8 : 0)),
          minimumSize: height != null
              ? MaterialStateProperty.all(infiniteWidth ? Size.fromHeight(height!) : Size(96, height!))
              : null),
      label: Text(buttonText),
    );
  }
}

class FloatingButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData iconData;
  final Color? customColor;
  final bool enabled;
  final bool isLoading;
  final String? heroTag;
  const FloatingButton(
      {Key? key,
      required this.onPressed,
      required this.iconData,
      this.customColor,
      this.enabled = true,
      this.isLoading = false,
      this.heroTag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          shadowColor:
              (customColor ?? Theme.of(context).primaryColor).withOpacity(0.6)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: const BorderRadius.all(
            Radius.circular(100),
          ),
          boxShadow: [
            BoxShadow(
              color: (customColor ?? Theme.of(context).primaryColor)
                  .withOpacity(0.36),
              blurRadius: 25,
            ),
          ],
        ),
        child: FloatingActionButton(
          heroTag: heroTag,
          elevation: 0,
          highlightElevation: 6,
          onPressed: isLoading ? null : (enabled ? onPressed : null),
          backgroundColor: customColor ??
              (isLoading
                  ? Theme.of(context).primaryColor
                  : (enabled
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).disabledColor)),
          child: isLoading
              ? CircularProgressIndicator(
                  color: Theme.of(context).scaffoldBackgroundColor,
                )
              : Icon(iconData),
        ),
      ),
    );
  }
}

class RouteBackButton extends StatelessWidget {
  const RouteBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AutoBackButton();
    // return context.router.parent()!.canPopSelfOrChildren ||
    //         context.router.canPopSelfOrChildren
    //     ? BackButton(
    //         color: Theme.of(context).textTheme.headline1!.color,
    //         onPressed: () {
    //           context.router.pop();
    //         },
    //       )
    //     : Container();
  }
}


class CircleButton extends StatelessWidget {
  const CircleButton(
      {Key? key,
      this.onPressed,
      required this.child,
      this.useOutline = false,
      this.elevation = 2,
      this.color = Colors.white,
      this.outlineColor})
      : super(key: key);
  final VoidCallback? onPressed;
  final Widget child;
  final double elevation;
  final Color color;
  final Color? outlineColor;
  final bool useOutline;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(5),
      color: onPressed == null ? Theme.of(context).disabledColor : color,
      shape: CircleBorder(
          side: useOutline
              ? BorderSide(
                  color: onPressed == null
                      ? Theme.of(context).disabledColor
                      : outlineColor ?? color,
                )
              : BorderSide.none),
      elevation: elevation,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(50),
        child: Container(padding: const EdgeInsets.all(3.0), child: child),
      ),
    );
  }
}
