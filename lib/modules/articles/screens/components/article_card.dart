import 'package:flutter/material.dart';
import 'package:geraisdm/widgets/common_placeholder.dart';

class ArticleCard extends StatelessWidget {
  const ArticleCard(
      {Key? key,
      required this.title,
      this.imageUrl,
      this.onTap,
      required this.date})
      : super(key: key);

  final String title;
  final String? imageUrl;
  final String date;
  final VoidCallback? onTap;

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
            ImagePlaceholder(
              imageUrl: imageUrl,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16), topRight: Radius.circular(16)),
              height: 140,
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
                  Text(
                    date,
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
