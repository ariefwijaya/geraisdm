import 'package:flutter/material.dart';
import 'package:geraisdm/widgets/common_placeholder.dart';

class SearchItemCard extends StatelessWidget {
  final String? icon;
  final bool locked;
  final String name;
  final String? description;
  final VoidCallback? onTap;
  final bool enableActionIcon;

  const SearchItemCard(
      {Key? key,
      this.icon,
      this.locked = false,
      required this.name,
      this.description,
      this.onTap,
      this.enableActionIcon = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      elevation: 0,
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Theme.of(context).highlightColor),
          borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        leading: Stack(
          alignment: Alignment.center,
          children: [
            ImagePlaceholder(imageUrl: icon, height: 60, width: 60),
            if (locked)
              Positioned.fill(
                child: Container(
                  child: const Icon(
                    Icons.lock,
                    size: 40,
                  ),
                  decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(18)),
                ),
              ),
          ],
        ),
        isThreeLine: description != null && description!.length > 33,
        title: Text(
          name,
          maxLines: 1,
        ),
        subtitle: description != null
            ? Text(
                description!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )
            : null,
        trailing: enableActionIcon ? const Icon(Icons.chevron_right) : null,
        onTap: locked ? null : onTap,
      ),
    );
  }
}
