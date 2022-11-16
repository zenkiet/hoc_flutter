// ignore_for_file: file_names
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_format_money_vietnam/flutter_format_money_vietnam.dart';

// Source
import 'package:shop_order/main/utils/AppColors.dart';
import 'package:shop_order/main/utils/AppWidget.dart';
import 'package:shop_order/main/store/AppStore.dart';
import 'package:shop_order/model/GSModel.dart';
import 'package:shop_order/utils/GSColors.dart';
import 'package:shop_order/utils/AppConstants.dart';
import 'package:shop_order/utils/GSDataProvider.dart';
import 'package:shop_order/utils/GSImages.dart';

// Redicrect
import 'GSCheckOutScreen.dart';
import 'GSRecommendationDetailsScreen.dart';

class GSCartScreen extends StatefulWidget {
  static String tag = '/GSCartScreen';

  const GSCartScreen({super.key});

  @override
  GSCartScreenState createState() => GSCartScreenState();
}

Future getCartProduct(String user) async {
  var result = await getUserCart(user);
  return result;
}

class GSCartScreenState extends State<GSCartScreen> {
  List<GSRecommendedModel> recommendedList = [];
  int totalCount = 0;
  int totalAmount = 0;
  AppStore appStore = AppStore();

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    final prefs = await SharedPreferences.getInstance();
    String username = prefs.getString('username') ?? '';
    recommendedList = await getCartProduct(username);
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
        title: Text("Giỏ Hàng", style: boldTextStyle()),
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
                        InkWell(
                          onTap: () {
                            GSRecommendationDetailsScreen(
                                    recommendedDetails: mData)
                                .launch(context);
                          },
                          child: Ink.image(
                            image: AssetImage(mData.image.validate()),
                            // fit: BoxFit.cover,
                            width: 80,
                            height: 80,
                          ),
                        ),
                        // Image.asset(mData.image.validate(),
                        //     fit: BoxFit.cover, height: 80, width: 80),
                        30.width,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(mData.title.validate(),
                                style: boldTextStyle(size: 17), maxLines: 1),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  mData.price.validate().round().toVND(),
                                  style: secondaryTextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      size: 14),
                                ),
                                8.width,
                                Text(mData.salePrice.validate().round().toVND(),
                                    style: boldTextStyle(
                                        color: redColor, size: 16)),
                              ],
                            ),
                            10.height,
                            Row(
                              children: [
                                commonCacheImageWidget(minusImage, 20,
                                        width: 20)
                                    .onTap(() {
                                  setState(() {
                                    var id = mData.id.validate();
                                    var gtyData = mData.qty.validate();
                                    deleteProductCart(id, 1);
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
                                commonCacheImageWidget(addImage, 20, width: 20)
                                    .onTap(() {
                                  setState(() {
                                    int id = mData.id.validate();
                                    addProductCart(id, 1);
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
                ).onTap(() {});
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
                        Text("Tổng:",
                            style: boldTextStyle(color: Colors.white)),
                        8.width,
                        Text(totalAmount.round().toVND(),
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

addProductCart(int id, int qty) async {
  final prefs = await SharedPreferences.getInstance();
  String user = prefs.getString('username') ?? '';
  var uri = Uri.parse('$baseUrl/add_product_cart/$user/$id/$qty');
  var response = await http.get(uri);
  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    if (data['status'] == 'update' || data['status'] == 'insert') {
      log("Thêm Thành Công");
    } else if (data['status'] == 'soldout') {
      await Fluttertoast.showToast(
          msg: "Sản phẩm đã hết hàng",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blueAccent,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      return false;
    }
  }
}

deleteProductCart(int id, int qty) async {
  final prefs = await SharedPreferences.getInstance();
  String user = prefs.getString('username') ?? '';
  var uri = Uri.parse('$baseUrl/delete_product_cart/$user/$id/$qty');
  var response = await http.get(uri);
  var data = json.decode(response.body);

  if (data['status'] == 'success') {
    return true;
  } else {
    return false;
  }
}
