import 'package:flutter/material.dart';
import 'package:shop_order/model/GSModel.dart';
import 'package:shop_order/screens/GSRecommendationDetailsScreen.dart';
import 'package:shop_order/utils/GSColors.dart';
import 'package:shop_order/utils/GSDataProvider.dart';
import 'package:shop_order/utils/GSImages.dart';
import 'package:shop_order/main.dart';
import 'package:shop_order/main/utils/AppColors.dart';
import 'package:shop_order/main/utils/AppWidget.dart';
import 'package:nb_utils/nb_utils.dart';

import 'GSCheckOutScreen.dart';

class GSCartScreen extends StatefulWidget {
  static String tag = '/GSCartScreen';

  const GSCartScreen({super.key});

  @override
  GSCartScreenState createState() => GSCartScreenState();
}

Future getUserCart() async {
  var result = await getTopDiscount(10);
  return result;
}

class GSCartScreenState extends State<GSCartScreen> {
  String url = 'not';
  String result = '';
  List<GSRecommendedModel> recommendedList = getRecommendedList();
  int totalCount = 0;
  int totalAmount = 0;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    result = await getUserCart();
    calculate();
  }

  calculate() async {
    totalAmount = 0;
    for (var element in recommendedList) {
      setState(() {
        totalAmount +=
            ((element.salePrice.validate()) * (element.qty.validate())).toInt();
      });
    }
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            appStore.isDarkModeOn ? scaffoldColorDark : Colors.white,
        elevation: 1,
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Text("$result", style: boldTextStyle()),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: ListView.separated(
              separatorBuilder: (_, i) => const Divider(),
              shrinkWrap: true,
              reverse: true,
              physics: const ClampingScrollPhysics(),
              itemCount: recommendedList.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (_, index) {
                GSRecommendedModel mData = recommendedList[index];
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(mData.image.validate(),
                            fit: BoxFit.cover, height: 80, width: 80),
                        30.width,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(mData.title.validate(),
                                style: boldTextStyle(), maxLines: 1),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "${mData.price.validate()} đ",
                                  style: secondaryTextStyle(
                                      decoration: TextDecoration.lineThrough),
                                ),
                                8.width,
                                Text("${mData.salePrice.validate()} đ",
                                    style: boldTextStyle(color: redColor)),
                              ],
                            ),
                            10.height,
                            Row(
                              children: [
                                commonCacheImageWidget(gs_minus_icon, 20,
                                        width: 20)
                                    .onTap(() {
                                  setState(() {
                                    var gtyData = mData.qty.validate();
                                    if (gtyData <= 1) return;
                                    var qty = gtyData - 1;
                                    mData.qty = qty;
                                    calculate();
                                  });
                                }),
                                16.width,
                                Row(
                                  children: [
                                    Text(mData.qty.toString(),
                                        style: boldTextStyle()),
                                  ],
                                ),
                                16.width,
                                commonCacheImageWidget(gs_add_icon, 20,
                                        width: 20)
                                    .onTap(() {
                                  setState(() {
                                    totalCount = mData.qty! + 1;
                                    mData.qty = totalCount;
                                    calculate();
                                  });
                                }),
                              ],
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ).onTap(() {
                  GSRecommendationDetailsScreen(recommendedDetails: mData)
                      .launch(context);
                });
              },
            ),
          ).expand(),
          AppButton(
            width: context.width(),
            color: gs_primary_color,
            shapeBorder: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))),
            onTap: () {
              GSCheckOutScreen().launch(context);
            },
            child: Row(
              children: [
                Text("Thanh Toán",
                        style: boldTextStyle(color: Colors.white, size: 18))
                    .expand(),
                Row(
                  children: [
                    Row(
                      children: [
                        Text("Tổng Tiền:",
                            style: boldTextStyle(color: Colors.white)),
                        8.width,
                        Text("$totalAmount đ",
                            style: boldTextStyle(color: Colors.white)),
                      ],
                    ),
                    8.width,
                    Image.asset(gs_next_icon,
                        width: 20, height: 20, color: Colors.white),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
