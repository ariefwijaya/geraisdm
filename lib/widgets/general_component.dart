import 'package:auto_route/auto_route.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:geraisdm/utils/helpers/launcher_helper.dart';
import 'package:geraisdm/widgets/image_viewer.dart';
import 'package:shimmer/shimmer.dart';
import 'package:video_player/video_player.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:geraisdm/constant/localizations.g.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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

class HtmlViewer extends StatelessWidget {
  final String htmlString;
  const HtmlViewer({Key? key, required this.htmlString}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Html(
      data: htmlString,
      onLinkTap: (url, renderContext, map, element) {
        if (url != null) {
          LauncherHelper.openUrl(url);
        }
      },
      onImageTap: (url, renderContext, attributes, element) {
        if (url != null) {
          context.router.pushWidget(ImageGalleryViewer(imageUrls: [url]),
              fullscreenDialog: true);
        }
      },
    );
  }
}

class VideoViewer extends StatefulWidget {
  final String url;
  const VideoViewer({Key? key, required this.url}) : super(key: key);

  @override
  State<VideoViewer> createState() => _VideoViewerState();
}

class _VideoViewerState extends State<VideoViewer> {
  late VideoPlayerController videoPlayerController;
  ChewieController? _chewieController;
  bool isError = false;

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(widget.url)
      ..initialize().then((value) {
        setState(() {
          _chewieController = ChewieController(
            videoPlayerController: videoPlayerController,
            autoPlay: false,
            looping: false,
          );
        });
      }).catchError((onError) {
        setState(() {
          isError = true;
        });
      });
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isError) {
      return Center(
        child: Text(LocaleKeys.video_player_error.tr()),
      );
    }
    return Center(
      child: _chewieController != null &&
              _chewieController!.videoPlayerController.value.isInitialized
          ? Chewie(
              controller: _chewieController!,
            )
          : const CircularProgressIndicator(),
    );
  }
}

class VideoYoutubeViewer extends StatefulWidget {
  final String idKey;
  const VideoYoutubeViewer({Key? key, required this.idKey}) : super(key: key);

  @override
  State<VideoYoutubeViewer> createState() => _VideoYoutubeViewerState();
}

class _VideoYoutubeViewerState extends State<VideoYoutubeViewer> {
  late YoutubePlayerController videoPlayerController;

  @override
  void initState() {
    super.initState();
    videoPlayerController = YoutubePlayerController(
      initialVideoId: widget.idKey,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: true,
      ),
    );
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
        controller: videoPlayerController, showVideoProgressIndicator: true);
  }
}
