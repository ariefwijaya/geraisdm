import 'package:flutter/material.dart';

class _IconPlaceholder extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double? size;
  final EdgeInsetsGeometry? padding;
  const _IconPlaceholder(
      {Key? key,
      required this.icon,
      required this.color,
      this.size,
      this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(color: color.withOpacity(0.08), shape: BoxShape.circle),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(20.0),
        child: Icon(
          icon,
          color: color,
          size: size ?? 53.5,
        ),
      ),
    );
  }
}

/// Error Circle icon as a placeholder
class ErrorIconPlaceholder extends StatelessWidget {
  final IconData? icon;
  final double? size;
  final EdgeInsetsGeometry? padding;
  const ErrorIconPlaceholder({Key? key, this.icon, this.size, this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _IconPlaceholder(
      color: Theme.of(context).errorColor,
      icon: icon ?? Icons.error,
      size: size,
      padding: padding,
    );
  }

  static Widget small({IconData? icon}) {
    return ErrorIconPlaceholder(
        icon: icon,
        size: 24,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10));
  }
}

/// Success Circle icon as a placeholder
class SuccessIconPlaceholder extends StatelessWidget {
  final IconData? icon;
  final double? size;
  final EdgeInsetsGeometry? padding;
  const SuccessIconPlaceholder({Key? key, this.icon, this.size, this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _IconPlaceholder(
      size: size,
      color: Theme.of(context).primaryColor,
      icon: icon ?? Icons.check_circle,
      padding: padding,
    );
  }

  static Widget small({IconData? icon}) {
    return SuccessIconPlaceholder(
        icon: icon,
        size: 24,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10));
  }
}
