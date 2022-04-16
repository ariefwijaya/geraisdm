import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geraisdm/config/routes/routes.gr.dart';
import 'package:geraisdm/widgets/components/search_bar.dart';

class HomeSearchbarSection extends StatelessWidget {
  const HomeSearchbarSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushRoute(const SearchRoute());
      },
      child: AbsorbPointer(
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const SearchBar()),
      ),
    );
  }
}
