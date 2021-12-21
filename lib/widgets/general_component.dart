import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class _SkeletonLoader extends StatelessWidget {
  final Widget child;
  const _SkeletonLoader({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.2),
      highlightColor:
          Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.1),
      child: child,
    );
  }
}

/// Circle skeleton loader
class SkeletonLoaderCircle extends StatelessWidget {
  final double size;
  const SkeletonLoaderCircle({Key? key, required this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _SkeletonLoader(
        child: Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          shape: BoxShape.circle),
    ));
  }
}

///Square Skeleton loader
class SkeletonLoaderSquare extends StatelessWidget {
  final double width;
  final double height;
  final double roundedRadius;
  const SkeletonLoaderSquare(
      {Key? key,
      required this.width,
      required this.height,
      this.roundedRadius = 8})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _SkeletonLoader(
        child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(roundedRadius)),
    ));
  }
}

class CustomChip extends StatelessWidget {
  final String title;
  final Color color;
  final VoidCallback? onTap;

  const CustomChip({
    Key? key,
    required this.title,
    required this.color,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 4,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: color.withOpacity(0.08),
        ),
        child: Text(
          title,
          style: Theme.of(context).textTheme.subtitle1!.copyWith(
                fontSize: 12,
                color: color,
              ),
        ),
      ),
    );
  }
}
