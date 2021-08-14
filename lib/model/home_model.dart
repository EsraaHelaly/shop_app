class HomeModel {
  bool status;
  HomeDataModel data;
  String message;

  HomeModel.fromJson(Map map) {
    if (map == null) {
      return;
    }

    status = map['status'];
    message = map['message'];

    data = HomeDataModel.fromJson(map['data']);
    // data = map['data'] != null ? HomeDataModel.fromJson(map['data']) : null;
  }
}

class HomeDataModel {
  List<BannersModel> banners = [];
  List<ProductsModel> products = [];

  HomeDataModel.fromJson(Map map) {
    if (map == null) {
      return;
    }
    map['banners'].forEach((e) {
      banners.add(BannersModel.fromJson(e));
    });

    map['products'].forEach((e) {
      products.add(ProductsModel.fromJson(e));
    });
  }
}

class ProductsModel {
  int id;
  dynamic price, oldPrice, discount;
  String image, name;
  bool inFavorite, inCart;

  ProductsModel.fromJson(Map map) {
    if (map == null) {
      return;
    }
    id = map['id'];
    price = map['price'];
    oldPrice = map['old_price'];
    image = map['image'];
    name = map['name'];
    discount = map['discount'];
    inFavorite = map['in_favorites'];
    inCart = map['in_cart'];
  }
}

class BannersModel {
  int id;
  String image;
  BannersModel.fromJson(Map map) {
    if (map == null) {
      return;
    }
    id = map['id'];
    image = map['image'];
  }
}
