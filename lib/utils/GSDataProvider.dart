import 'dart:convert';

import 'package:nb_utils/nb_utils.dart';
import 'package:shop_order/model/GSModel.dart';
import 'package:shop_order/utils/GSConstants.dart';
import 'package:shop_order/utils/GSImages.dart';

import 'package:http/http.dart' as http;

List<SliderModel> getSliderList() {
  List<SliderModel> list = [];
  int countSlider = imageSlider.length;
  for (int i = 0; i < countSlider; i++) {
    list.add(SliderModel(image: imageSlider[i]));
  }
  return list;
}

List<CategoryModel> getCategoryList() {
  List<CategoryModel> list = [];
  int countCategory = imageCategory.length;
  for (int i = 0; i < countCategory; i++) {
    String nameCate = imageCategory[i][0];
    String imageCate = imageCategory[i][1];
    list.add(CategoryModel(image: imageCate, catgoryName: nameCate));
  }
  return list;
}

Future getTopDiscount(int amount) async {
  List<GSRecommendedModel> list = [];
  var uri = Uri.parse('$baseUrl/top_discount/$amount');
  var response = await http.get(uri);
  var data = json.decode(utf8.decode(response.bodyBytes));
  if (data['status'] == 'success') {
    var listData = data['data'];
    int countListData = listData.length;
    for (int i = 0; i < countListData; i++) {
      var value = listData[i];
      // int id = value['id_product'];
      String name = value['name'];
      String description = value['description'];
      double price = double.parse(value['price']);
      int ranking = value['ranking'];
      String image = imageSource + value['image'];
      double discount = double.parse(value['discount']);
      int quantity = value['quantity'];
      // int id_category = value['id_category'];

      double salePrice = price - (price * discount / 100);

      list.add(GSRecommendedModel(
        offer: discount.round().toString(),
        image: image,
        price: price,
        salePrice: salePrice,
        title: name,
        description: description,
        quantity: 'Còn $quantity sản phẩm',
        qty: quantity,
        total: 0,
        ranking: ranking,
      ));
    }
    return list;
  } else {}
}

Future getTopRanking(int amount) async {
  List<GSRecommendedModel> list = [];
  var uri = Uri.parse('$baseUrl/top_ranking/$amount');
  var response = await http.get(uri);
  var data = json.decode(utf8.decode(response.bodyBytes));
  if (data['status'] == 'success') {
    var listData = data['data'];
    int countListData = listData.length;
    for (int i = 0; i < countListData; i++) {
      var value = listData[i];
      // int id = value['id_product'];
      String name = value['name'];
      String description = value['description'];
      double price = double.parse(value['price']);
      int ranking = value['ranking'];
      String image = imageSource + value['image'];
      double discount = double.parse(value['discount']);
      int quantity = value['quantity'];
      // int id_category = value['id_category'];

      double salePrice = price - (price * discount / 100);

      list.add(GSRecommendedModel(
        offer: discount.round().toString(),
        image: image,
        price: price,
        salePrice: salePrice,
        title: name,
        description: description,
        quantity: 'Còn $quantity sản phẩm',
        qty: quantity,
        total: 0,
        ranking: ranking,
      ));
    }
    return list;
  } else {}
}

Future getCategoryProduct(String category) async {
  if (category == 'Bánh') {
    category = 'cake';
  } else if (category == 'Kẹo') {
    category = 'candy';
  } else if (category == 'Đồ Chiên') {
    category = 'fastfood';
  } else if (category == 'Trái Cây') {
    category = 'fruit';
  } else if (category == 'Kem') {
    category = 'icecream';
  }

  var uri = Uri.parse('$baseUrl/category_product/$category');
  var response = await http.get(uri);
  var data = json.decode(utf8.decode(response.bodyBytes));
  if (data['status'] == 'success') {
    var listData = data['data'];
    int countListData = listData.length;
    List<GSRecommendedModel> list = [];
    for (int i = 0; i < countListData; i++) {
      var value = listData[i];
      // int id = value['id_product'];
      String name = value['name'];
      String description = value['description'];
      double price = double.parse(value['price']);
      int ranking = value['ranking'];
      String image = imageSource + value['image'];
      double discount = double.parse(value['discount']);
      int quantity = value['quantity'];
      // int id_category = value['id_category'];

      double salePrice = price - (price * discount / 100);

      list.add(
        GSRecommendedModel(
          image: image,
          price: price,
          salePrice: salePrice,
          description: description,
          title: name,
          quantity: 'Còn $quantity sản phẩm',
          ranking: ranking,
        ),
      );
    }
    return list;
  } else {}
}

List<GSRecommendedModel> getRecommendedList() {
  List<GSRecommendedModel> list = [];
  list.add(GSRecommendedModel(
      image: gs_cauliflower_img,
      price: 30,
      salePrice: 10,
      title: "Cauliflower",
      quantity: "100gr",
      qty: 1,
      total: 0,
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat"));
  list.add(GSRecommendedModel(
      offer: "15%",
      image: gs_carrot_img,
      price: 20,
      salePrice: 10,
      title: "Carrot",
      quantity: "50gr",
      qty: 1,
      total: 0,
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat"));
  list.add(GSRecommendedModel(
      offer: "30%",
      image: gs_pineappple_img,
      price: 20,
      salePrice: 10,
      title: "Pineapple",
      quantity: "100gr",
      qty: 1,
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat"));
  list.add(GSRecommendedModel(
      offer: "30%",
      image: gs_assian_pear,
      price: 30,
      salePrice: 20,
      title: "Asian pear",
      quantity: "100gr",
      qty: 1,
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat"));
  return list;
}

List<GSRecommendedModel> getCategoryListDetailsList() {
  List<GSRecommendedModel> list = [];

  list.add(
    GSRecommendedModel(
      image: gs_cauliflower_img,
      price: 0.22,
      salePrice: 0.12,
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat",
      title: "Cauliflower",
      quantity: "100gr",
    ),
  );
  list.add(
    GSRecommendedModel(
      offer: "15%",
      image: gs_carrot_img,
      price: 0.30,
      salePrice: 0.15,
      description:
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat",
      title: "Carrot",
      quantity: "50gr",
    ),
  );
  return list;
}

List<GSMyOrderModel> getOnCompletedList() {
  List<GSMyOrderModel> list = [];
  list.add(GSMyOrderModel(
      title: "Cauliflower",
      date: "Jan 05, 11:30AM",
      orderStatus: GSCompleted,
      image: gs_cauliflower_img,
      cost: "0.12",
      address: "8618 Hickory Avenue Newington, CT 06111",
      orderId: "GS1223THG"));
  list.add(GSMyOrderModel(
      title: "Cauliflower",
      date: "Jan 05, 11:30AM",
      orderStatus: GSCompleted,
      image: gs_cauliflower_img,
      cost: "0.12",
      address: "8618 Hickory Avenue Newington, CT 06111",
      orderId: "GS1223THG"));
  list.add(GSMyOrderModel(
      title: "Cauliflower",
      date: "Jan 05, 11:30AM",
      orderStatus: GSCompleted,
      image: gs_cauliflower_img,
      cost: "0.12",
      address: "8618 Hickory Avenue Newington, CT 06111",
      orderId: "GS1223THG"));
  list.add(GSMyOrderModel(
      title: "Cauliflower",
      date: "Jan 05, 11:30AM",
      orderStatus: GSCompleted,
      image: gs_cauliflower_img,
      cost: "0.12",
      address: "8618 Hickory Avenue Newington, CT 06111",
      orderId: "GS1223THG"));
  return list;
}

List<GSMyOrderModel> getOnProgressList() {
  List<GSMyOrderModel> list = [];
  list.add(GSMyOrderModel(
      title: "Carrot",
      date: "Jan 30, 11:30AM",
      orderStatus: GSOnProgress,
      image: gs_carrot_img,
      orderId: "GSJS655"));
  list.add(GSMyOrderModel(
      title: "Carrot",
      date: "Jan 30, 11:30AM",
      orderStatus: GSOnProgress,
      image: gs_carrot_img,
      orderId: "GSJS655"));
  list.add(GSMyOrderModel(
      title: "Carrot",
      date: "Jan 30, 11:30AM",
      orderStatus: GSOnProgress,
      image: gs_carrot_img,
      orderId: "GSJS655"));
  list.add(GSMyOrderModel(
      title: "Carrot",
      date: "Jan 30, 11:30AM",
      orderStatus: GSOnProgress,
      image: gs_carrot_img,
      orderId: "GSJS655"));
  return list;
}

List<GSMyOrderModel> getCancelOrderList() {
  List<GSMyOrderModel> list = [];
  list.add(GSMyOrderModel(
      title: "Pineapple",
      date: "Jan 1, 2:00PM",
      orderStatus: GSCancel,
      image: gs_pineappple_img,
      orderId: "GSOLN892"));
  list.add(GSMyOrderModel(
      title: "Pineapple",
      date: "Jan 1, 2:00PM",
      orderStatus: GSCancel,
      image: gs_pineappple_img,
      orderId: "GSOLN892"));
  list.add(GSMyOrderModel(
      title: "Pineapple",
      date: "Jan 1, 2:00PM",
      orderStatus: GSCancel,
      image: gs_pineappple_img,
      orderId: "GSOLN892"));
  list.add(GSMyOrderModel(
      title: "Pineapple",
      date: "Jan 1, 2:00PM",
      orderStatus: GSCancel,
      image: gs_pineappple_img,
      orderId: "GSOLN892"));
  return list;
}

List<GSAddressModel> getAddressList() {
  List<GSAddressModel> list = [];
  list.add(GSAddressModel(
      address: "1980  Cicero Street",
      city: "Malden",
      state: "MO",
      pinCode: "63863"));
  list.add(GSAddressModel(
      address: "122 Bessida St, Bloomfield, NJ, 07003",
      city: "Cicero",
      state: "IL",
      pinCode: "60650"));
  return list;
}

List<GSPromoModel> getPromoList() {
  List<GSPromoModel> list = [];
  list.add(GSPromoModel(
      promoImage: gs_slider_image1,
      offer: "Fruits 30% Off Promos",
      offerDate: "Available until 20 Feb 2020"));
  list.add(GSPromoModel(
      promoImage: gs_slider_image2,
      offer: "Grocery 30% Off Promos",
      offerDate: "Available until 25 Feb 2020"));
  return list;
}

List<GSNotificationModel> getNotificationList() {
  List<GSNotificationModel> list = [];
  list.add(GSNotificationModel(
      title: "You got 10% off from your last order",
      subTitle: "The gift can you can use in next order",
      heading: "Promo"));
  list.add(GSNotificationModel(
      title: "Waiting for payment",
      subTitle: "The gift can you can use in next order",
      heading: "Transaction"));
  list.add(GSNotificationModel(
      title: "Rate your order experience",
      subTitle: "The gift can you can use in next order",
      heading: "Info"));
  return list;
}
