import 'package:flutter/material.dart';
import 'package:shop_order/utils/GSColors.dart';
import 'package:shop_order/utils/GSImages.dart';
import 'package:shop_order/utils/GSWidgets.dart';
import 'package:shop_order/main.dart';
import 'package:shop_order/main/utils/AppColors.dart';
import 'package:nb_utils/nb_utils.dart';

class GSSuccessfulOrderScreen extends StatefulWidget {
  static String tag = '/GSSuccessfulOrderScreen';

  @override
  GSSuccessfulOrderScreenState createState() => GSSuccessfulOrderScreenState();
}

class GSSuccessfulOrderScreenState extends State<GSSuccessfulOrderScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    setStatusBarColor(gs_primary_color);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    setStatusBarColor(appStore.isDarkModeOn ? scaffoldColorDark : Colors.white);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setStatusBarColor(gs_primary_color);
    return Scaffold(
      backgroundColor: gs_primary_color,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(gs_successful_img, height: 120, width: 120, fit: BoxFit.cover),
              30.height,
              Text(
                "John, your order has been successful",
                style: boldTextStyle(color: Colors.white, size: 20),
                textAlign: TextAlign.center,
              ),
              20.height,
              createRichText(list: [
                TextSpan(text: "Check your status in", style: primaryTextStyle(color: Colors.white, size: 18)),
                TextSpan(text: " My Order\n", style: boldTextStyle(color: Colors.white)),
                TextSpan(text: "about next steps information.", style: primaryTextStyle(color: Colors.white, size: 18)),
              ]),
            ],
          ).paddingAll(16).paddingBottom(context.height() * 0.2),
          Container(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 30),
            width: context.width(),
            decoration: boxDecorationWithRoundedCorners(
              borderRadius: radiusOnly(topLeft: 16, topRight: 16),
              backgroundColor: appStore.isDarkModeOn ? scaffoldSecondaryDark : Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Preparing your order", style: boldTextStyle()),
                16.height,
                Text("Your order will be prepared and will come soon", style: secondaryTextStyle()),
                40.height,
                gsAppButton(context, "Track My Order", () {
                  finish(context);
                }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
