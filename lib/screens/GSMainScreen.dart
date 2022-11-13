import 'package:flutter/material.dart';
import 'package:shop_order/screens/GSCartScreen.dart';
import 'package:shop_order/screens/GSDashboardScreen.dart';
import 'package:shop_order/screens/GSMyOrderScreen.dart';
import 'package:shop_order/utils/GSColors.dart';
import 'package:shop_order/main.dart';
import 'package:shop_order/main/utils/AppColors.dart';
import 'package:nb_utils/nb_utils.dart';

import 'GSAccountScreen.dart';

class GSMainScreen extends StatefulWidget {
  static String tag = '/GSMainScreen';

  @override
  GSMainScreenState createState() => GSMainScreenState();
}

class GSMainScreenState extends State<GSMainScreen> {
  final globalScaffoldKey = GlobalKey<ScaffoldState>();
  int currentIndex = 0;
  final List<Widget> pages = [
    GSDashboardScreen(),
    GSCartScreen(),
    GSMyOrderScreen(),
    GSAccountScreen(),
  ];

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    setStatusBarColor(appStore.isDarkModeOn ? scaffoldColorDark : Colors.white, statusBarIconBrightness: Brightness.light);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalScaffoldKey,
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: appStore.isDarkModeOn ? scaffoldColorDark : Colors.white,
        currentIndex: currentIndex,
        onTap: onTabTapped,
        type: BottomNavigationBarType.fixed,
        selectedIconTheme: IconThemeData(color: gs_primary_color),
        unselectedIconTheme: IconThemeData(color: Colors.grey[300]),
        selectedItemColor: appStore.isDarkModeOn ? textSecondaryColorGlobal : Colors.black,
        selectedFontSize: 12,
        unselectedFontSize: 12,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.store), label: "Shop"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag), label: "My Order"),
          BottomNavigationBarItem(icon: Icon(Icons.supervisor_account_sharp), label: "Account"),
        ],
      ),
    );
  }
}
