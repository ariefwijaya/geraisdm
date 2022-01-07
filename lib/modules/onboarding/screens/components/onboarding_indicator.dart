import 'package:flutter/material.dart';

class OnboardIndicator extends StatelessWidget {
  /// how many dots indicator to be shown
  final int length;

  /// Current index of active Indicator
  final int currentIndex;

  /// will be shown as an active dots
  final Color? activeColor;
  const OnboardIndicator(
      {Key? key, required this.length, this.currentIndex = 0, this.activeColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
          length,
          (index) => currentIndex == index
              ? //active
              Container(
                  width: 15,
                  height: 6,
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Theme.of(context).primaryColor),
                )
              : Container(
                  width: 6,
                  height: 6,
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).disabledColor),
                )),
    );
  }
}
