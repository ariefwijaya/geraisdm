import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:geraisdm/constant/assets.gen.dart';

class ImageGalleryViewer extends StatefulWidget {
  final List<String> imageUrls;
  final int? initialIndex;
  const ImageGalleryViewer(
      {Key? key, required this.imageUrls, this.initialIndex})
      : super(key: key);

  @override
  State<ImageGalleryViewer> createState() => _ImageGalleryViewerState();
}

class _ImageGalleryViewerState extends State<ImageGalleryViewer> {
  late PageController controller;

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: widget.initialIndex ?? 0);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          PhotoViewGallery.builder(
            pageController: controller,
            scrollPhysics: const BouncingScrollPhysics(),
            builder: (BuildContext context, int index) {
              return PhotoViewGalleryPageOptions.customChild(
                child: Stack(
                  children: [
                    _buildImage(context, widget.imageUrls[index]),
                    Container(
                        padding: const EdgeInsets.all(10),
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          "${index + 1}",
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                        ))
                  ],
                ),
                initialScale: PhotoViewComputedScale.contained * 1,
                minScale: PhotoViewComputedScale.contained * 1,
                maxScale: PhotoViewComputedScale.covered * 1.5,
                heroAttributes: PhotoViewHeroAttributes(
                    tag: "$index ${widget.imageUrls[index]}"),
              );
            },
            itemCount: widget.imageUrls.length,
            loadingBuilder: (context, progress) => Center(
              child: SizedBox(
                width: 20.0,
                height: 20.0,
                child: CircularProgressIndicator(
                  value: progress == null || progress.expectedTotalBytes == null
                      ? null
                      : progress.cumulativeBytesLoaded /
                          progress.expectedTotalBytes!,
                ),
              ),
            ),
          ),
          Positioned(
              top: 30,
              left: 16,
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).shadowColor.withOpacity(0.3),
                    shape: BoxShape.circle),
                child: IconButton(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    onPressed: () {
                      context.popRoute();
                    },
                    icon: const Icon(Icons.close)),
              ))
        ],
      ),
    );
  }

  Widget _buildImage(BuildContext context, String imageUrl) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
            image: DecorationImage(fit: BoxFit.contain, image: imageProvider)),
      ),
      placeholder: (context, url) =>
          const Center(child: CircularProgressIndicator()),
      errorWidget: (context, url, error) => Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: Assets.images.icon.squarePlaceholder))),
    );
  }
}
