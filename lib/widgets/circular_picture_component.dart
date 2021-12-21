import '../../../../constant/assets.gen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CircularPicture extends StatelessWidget {
  final String? picture;
  const CircularPicture({Key? key, this.picture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (picture != null) {
      return CachedNetworkImage(
        imageUrl: picture!,
        imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                image: DecorationImage(image: imageProvider))),
        errorWidget: (context, url, error) => Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            image: DecorationImage(image: Assets.images.icon.squarePlaceholder),
          ),
        ),
      );
    } else {
      return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          image: DecorationImage(image: Assets.images.icon.squarePlaceholder),
        ),
      );
    }
  }
}
