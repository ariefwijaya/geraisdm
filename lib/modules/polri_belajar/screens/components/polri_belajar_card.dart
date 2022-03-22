import 'package:flutter/material.dart';
import 'package:geraisdm/widgets/common_placeholder.dart';
import 'package:geraisdm/constant/localizations.g.dart';
import 'package:easy_localization/easy_localization.dart';

class PolriBelajarCard extends StatelessWidget {
  const PolriBelajarCard(
      {Key? key,
      required this.title,
      this.imageUrl,
      this.onTap,
      required this.date,
      this.isTrending = false,
      this.totalComment})
      : super(key: key);

  final String title;
  final String? imageUrl;
  final String date;
  final VoidCallback? onTap;
  final bool isTrending;
  final int? totalComment;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 8,
      shadowColor: Theme.of(context).shadowColor.withOpacity(0.1),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                ImagePlaceholder(
                  imageUrl: imageUrl,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16)),
                  height: 140,
                ),
                if (isTrending)
                  Positioned(
                      top: 16,
                      right: 16,
                      child: Card(
                        color: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 6),
                          child: Text(
                            LocaleKeys.polri_belajar_trending.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor),
                          ),
                        ),
                      ))
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          date,
                        ),
                      ),
                      if (totalComment != null)
                        Row(
                          children: [
                            Icon(
                              Icons.comment_outlined,
                              color: Theme.of(context).unselectedWidgetColor,
                            ),
                            const SizedBox(width: 6),
                            Text("$totalComment")
                          ],
                        )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
