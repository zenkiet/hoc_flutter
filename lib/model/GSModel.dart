class User {
  // username, fullname, email, password, phone, address
  String? username;
  String? fullname;
  String? email;
  String? password;
  late String phone;
  late String address;

  User(
      {this.username,
      this.fullname,
      this.email,
      this.password,
      this.phone = '',
      this.address = ''});
}

class SliderModel {
  String? image;

  SliderModel({this.image});
}

class CategoryModel {
  String? image;
  String? catgoryName;

  CategoryModel({this.image, this.catgoryName});
}

class GSRecommendedModel {
  String? offer;
  String? image;
  double? salePrice;
  double? price;
  String? title;
  String? quantity;
  String? description;
  int? qty;
  int? total;
  int? ranking;

  GSRecommendedModel(
      {this.offer,
      this.image,
      this.salePrice,
      this.price,
      this.title,
      this.quantity,
      this.description,
      this.qty,
      this.total,
      this.ranking});
}

class TopProductModel {
  int? id;
  String? name;
  String? description;
  double? price;
  int? ranking;
  String? image;
  int? discount;
  int? quantity;

  TopProductModel(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.ranking,
      this.image,
      this.discount,
      this.quantity});
}

/*class GSCategoryListDetailsModel {
  String offer;
  String image;
  String salePrice;
  String price;
  String description;
  String quantity;
  String title;

  GSCategoryListDetailsModel({this.offer, this.image, this.salePrice, this.price, this.description, this.quantity, this.title});
}*/

class GSMyOrderModel {
  String? title;
  String? date;
  int? orderStatus;
  String? image;
  String? address;
  String? cost;
  String? orderId;

  GSMyOrderModel(
      {this.title,
      this.date,
      this.orderStatus,
      this.image,
      this.address,
      this.cost,
      this.orderId});
}

class GSAddressModel {
  String? address;
  String? city;
  String? state;
  String? pinCode;

  GSAddressModel({this.address, this.city, this.state, this.pinCode});
}

class GSPromoModel {
  String? promoImage;
  String? offer;
  String? offerDate;

  GSPromoModel({this.promoImage, this.offer, this.offerDate});
}

class GSNotificationModel {
  String? title;
  String? subTitle;
  String? heading;

  GSNotificationModel({this.title, this.subTitle, this.heading});
}
