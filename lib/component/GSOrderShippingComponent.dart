// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Source
import 'package:shop_order/utils/GSDataProvider.dart';
import 'package:shop_order/model/GSModel.dart';
import 'package:shop_order/utils/widget/order.dart';

class GSOrderShippingComponent extends StatefulWidget {
  static String tag = '/GSOrderShippingComponent';

  const GSOrderShippingComponent({super.key});

  @override
  GSOrderShippingComponentState createState() =>
      GSOrderShippingComponentState();
}

class GSOrderShippingComponentState extends State<GSOrderShippingComponent> {
  int ratingNum = 0;
  List<GSMyOrderModel> shipppingOrderList = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    final pref = await SharedPreferences.getInstance();
    String username = pref.getString('username')!;
    var data = await getOrderStatus(username, 'shipping');
    setState(() {
      shipppingOrderList = data;
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          myOrderWidget(
            ratingBar: RatingBar.builder(
              initialRating: 0,
              minRating: 0,
              itemCount: 5,
              glow: false,
              maxRating: 5,
              itemSize: 30,
              itemBuilder: (context, _) =>
                  const Icon(Icons.star, color: Colors.amber),
              onRatingUpdate: (rating) {
                ratingNum = rating.toInt();
                setState(() {});
              },
            ),
            orderList: shipppingOrderList,
            onTap: () {},
          ),
          cartNotFound()
              .visible(shipppingOrderList.isEmpty)
              .paddingTop(context.height() * 0.3)
        ],
      ),
    );
  }
}
