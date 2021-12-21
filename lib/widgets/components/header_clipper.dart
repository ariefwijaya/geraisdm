import 'package:flutter/material.dart';

class HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 50);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 50);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class HeaderRounded extends StatelessWidget {
  final double height;
  const HeaderRounded({Key? key, this.height = 140}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: HeaderClipper(),
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColorDark,
            ])),
        height: height,
        // padding: padding,
      ),
    );
  }
}
