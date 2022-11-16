import 'package:flutter/material.dart';
import 'package:shop_order/model/GSModel.dart';
import 'package:shop_order/screens/GSOrderProgressDetailsScreen.dart';
import 'package:shop_order/utils/GSConstants.dart';
import 'package:shop_order/utils/GSImages.dart';
import 'package:shop_order/main.dart';
import 'package:shop_order/main/utils/AppColors.dart';
import 'package:nb_utils/nb_utils.dart';

Widget myOrderWidget(
    {Widget? ratingBar,
    required List<GSMyOrderModel> orderList,
    Function? onTap}) {
  return ListView.builder(
    padding: const EdgeInsets.only(top: 8),
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: orderList.length,
    itemBuilder: (context, index) {
      GSMyOrderModel mData = orderList[index];

      return Container(
        padding: const EdgeInsets.all(16),
        decoration: boxDecorationWithRoundedCorners(
          boxShadow: defaultBoxShadow(),
          borderRadius: radius(0),
          backgroundColor:
              appStore.isDarkModeOn ? scaffoldSecondaryDark : Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(mData.title!, style: boldTextStyle()),
                    4.height,
                    Text("Delivered on ${mData.date}",
                        style: secondaryTextStyle()),
                    4.height,
                    Container(
                      decoration: boxDecorationWithRoundedCorners(
                          borderRadius: radius(4),
                          backgroundColor: (mData.orderStatus == GSCompleted)
                              ? Colors.green
                              : (mData.orderStatus == GSOnProgress)
                                  ? Colors.orangeAccent
                                  : (mData.orderStatus == GSCancel)
                                      ? Colors.red
                                      : Container() as Color),
                      padding: const EdgeInsets.only(
                          left: 8, right: 8, top: 4, bottom: 4),
                      child: Text(
                          (mData.orderStatus == GSCompleted)
                              ? "Completed"
                              : (mData.orderStatus == GSOnProgress)
                                  ? "Delivering"
                                  : (mData.orderStatus == GSCancel)
                                      ? "Canceled"
                                      : Container() as String,
                          style: boldTextStyle(color: Colors.white, size: 12)),
                    ),
                    8.height,
                  ],
                ).expand(),
                Image.asset(mData.image!,
                    height: 80, width: 80, fit: BoxFit.cover)
              ],
            ),
            8.height,
            const Divider(),
            ratingBar!
          ],
        ),
      ).onTap(() {
        GSOrderProgressDetailsScreen(orderProgressList: mData).launch(context);
      }).paddingOnly(left: 16, right: 16, top: 8, bottom: 8);
    },
  );
}

Widget cartNotFound() {
  return Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(gs_empty_cart, fit: BoxFit.cover, height: 80, width: 80),
        8.height,
        Text("HIện tại không có đơn hàng.", style: boldTextStyle()),
      ],
    ),
  );
}
