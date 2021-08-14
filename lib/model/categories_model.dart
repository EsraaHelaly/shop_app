class CategoriesModel {
  bool status;
  CategoriesDataModel data;

  CategoriesModel.fromJson(Map map) {
    if (map == null) {
      return;
    }

    status = map['status'];

    data = CategoriesDataModel.fromJson(map['data']);
  }
}

class CategoriesDataModel {
  int currentPage;
  List<DataModel> data = [];

  CategoriesDataModel.fromJson(Map map) {
    if (map == null) {
      return;
    }
    currentPage = map['current_page'];

    map['data'].forEach((e) {
      data.add(DataModel.fromJson(e));
    });
  }
}

class DataModel {
  int id;

  String image, name;

  DataModel.fromJson(Map map) {
    if (map == null) {
      return;
    }
    id = map['id'];

    image = map['image'];
    name = map['name'];
  }
}
