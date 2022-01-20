import 'package:geraisdm/constant/localizations.g.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeLayoutContent extends StatelessWidget {
  final List<PageRouteInfo> listPage;
  final List<BottomNavigationBarItem> bottomNavBarItems;
  const HomeLayoutContent(
      {Key? key, required this.listPage, required this.bottomNavBarItems})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime? currentBackPressTime;

    Future<bool> onWillPop() async {
      final DateTime now = DateTime.now();
      if (currentBackPressTime == null ||
          now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
        currentBackPressTime = now;
        Fluttertoast.showToast(msg: LocaleKeys.tap_twice_to_exit.tr());
        return false;
      }
      return true;
    }

    bool onTabsWillPop(TabsRouter tabsRouter) {
      if (tabsRouter.activeIndex == 0) {
        return true;
      }
      tabsRouter.setActiveIndex(0);
      return false;
    }

    return AutoTabsScaffold(
      routes: listPage,
      bottomNavigationBuilder: (context, tabsRouter) => WillPopScope(
        onWillPop: () async {
          if (onTabsWillPop(tabsRouter)) {
            return onWillPop();
          } else {
            return false;
          }
        },
        child: BottomNavigationBar(
            elevation: 7,
            selectedLabelStyle:
                const TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
            unselectedLabelStyle:
                const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            selectedItemColor: Theme.of(context).primaryColor,
            unselectedItemColor: Theme.of(context).unselectedWidgetColor,
            type: BottomNavigationBarType.fixed,
            currentIndex: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,
            // currentIndex: _selectedIndex,
            // onTap: _onNavBarTapped,
            items: bottomNavBarItems),
      ),
    );
  }
}
