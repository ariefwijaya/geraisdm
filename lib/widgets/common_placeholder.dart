import '../../../../constant/assets.gen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import 'icon_alert_component.dart';

class _CommonPlaceholderBuilder extends StatelessWidget {
  final Widget? icon;
  final String title;
  final String subtitle;
  final Widget? action;
  final bool center;
  final double titleSize;
  final EdgeInsets? padding;
  final TextAlign? textAlign;
  const _CommonPlaceholderBuilder(
      {Key? key,
      this.icon,
      required this.title,
      required this.subtitle,
      this.action,
      this.titleSize = 20,
      this.center = true,
      this.padding,
      this.textAlign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(24),
      child: center
          ? Center(
              child: _buildContent(context),
            )
          : _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) icon!,
        if (icon != null) const SizedBox(height: 48),
        Text(title,
            textAlign: textAlign ?? TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(fontSize: titleSize)),
        const SizedBox(height: 20),
        MarkdownBody(
          data: subtitle,
          styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
              textAlign: WrapAlignment.center,
              p: const TextStyle(fontSize: 16)),
        ),
        const SizedBox(height: 20),
        if (action != null) action!
      ],
    );
  }
}

class CommonPlaceholder {
  CommonPlaceholder._();

  static Widget error(
      {required String title,
      required String subtitle,
      Widget? action,
      bool center = true,
      double titleSize = 20,
      EdgeInsets? padding,
      TextAlign? textAlign}) {
    return _CommonPlaceholderBuilder(
      icon: const ErrorIconPlaceholder(),
      title: title,
      subtitle: subtitle,
      action: action,
      center: center,
      titleSize: titleSize,
      padding: padding,
      textAlign: textAlign,
    );
  }

  static Widget success(
      {required String title,
      required String subtitle,
      Widget? action,
      bool center = true,
      double titleSize = 20,
      TextAlign? textAlign}) {
    return _CommonPlaceholderBuilder(
      icon: const SuccessIconPlaceholder(),
      title: title,
      subtitle: subtitle,
      action: action,
      center: center,
      titleSize: titleSize,
      textAlign: textAlign,
    );
  }

  static Widget customIcon(
      {required Widget icon,
      required String title,
      required String subtitle,
      Widget? action,
      bool center = true,
      double titleSize = 20,
      TextAlign? textAlign}) {
    return _CommonPlaceholderBuilder(
      icon: icon,
      title: title,
      subtitle: subtitle,
      action: action,
      center: center,
      titleSize: titleSize,
      textAlign: textAlign,
    );
  }

  static Widget noIcon(
      {required String title,
      required String subtitle,
      Widget? action,
      bool center = true,
      double titleSize = 20,
      TextAlign? textAlign}) {
    return _CommonPlaceholderBuilder(
      title: title,
      subtitle: subtitle,
      action: action,
      center: center,
      titleSize: titleSize,
      textAlign: textAlign,
    );
  }
}

class ImagePlaceholder extends StatelessWidget {
  final String? imageUrl;
  final double? height;
  final double? width;
  final BoxShape shape;
  final BorderRadiusGeometry? borderRadius;
  final BoxFit? imageFit;
  final ImageProvider<Object>? assetsPlaceholder;
  const ImagePlaceholder(
      {Key? key,
      this.height,
      this.width,
      this.imageUrl,
      this.borderRadius,
      this.shape = BoxShape.rectangle,
      this.imageFit = BoxFit.cover,
      this.assetsPlaceholder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (imageUrl != null) {
      return CachedNetworkImage(
        imageUrl: imageUrl!,
        useOldImageOnUrlChange: true,
        placeholder: (context, url) => _buildPlaceholder(context),
        imageBuilder: (context, imageProvider) => Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
                shape: shape,
                borderRadius: borderRadius,
                image: DecorationImage(
                  fit: imageFit,
                  image: imageProvider,
                ))),
        errorWidget: (context, url, error) => _buildPlaceholder(context),
      );
    } else {
      return _buildPlaceholder(context);
    }
  }

  Widget _buildPlaceholder(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          shape: shape,
          borderRadius: borderRadius,
          image: DecorationImage(
            fit: imageFit,
            image: assetsPlaceholder ?? Assets.images.icon.squarePlaceholder,
          )),
    );
  }
}

class HighlightInfoCard extends StatelessWidget {
  final String title;

  const HighlightInfoCard({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).indicatorColor),
          borderRadius: BorderRadius.circular(16),
          color: Theme.of(context).primaryColor.withOpacity(0.1)),
      child: Row(
        children: [
          const Icon(Icons.info, size: 24),
          const SizedBox(width: 12),
          Expanded(
              child: MarkdownBody(
            data: title,
            styleSheet: MarkdownStyleSheet(
                p: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context).textTheme.headline1!.color),
                strong: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).primaryColor)),
          ))
        ],
      ),
    );
  }
}
