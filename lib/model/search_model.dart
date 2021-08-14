class SearchModel {
  bool status;
  String message;
  Data data;

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int currentPage;
  List<Product> data = [];

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];

    json['data'].forEach((e) {
      data.add(Product.fromJson(e));
    });
  }
}

class Product {
  int id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String image;
  String name;
  String description;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
