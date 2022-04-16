import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:geraisdm/constant/localizations.g.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final VoidCallback? onTap;

  const SearchBar({Key? key, this.controller, this.onChanged, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoSearchTextField(
      controller: controller,
      onChanged: onChanged,
      onTap: onTap,
      itemSize: 18,
      prefixInsets: const EdgeInsets.all(10),
      style: const TextStyle(fontSize: 14),
      decoration: BoxDecoration(
          color: Theme.of(context).indicatorColor,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Theme.of(context).primaryColor)),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
      placeholder: LocaleKeys.seach_hint.tr(),
    );
  }
}
