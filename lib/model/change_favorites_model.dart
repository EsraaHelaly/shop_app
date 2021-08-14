class ChangeFavoritesModel {
  bool status;
  String message;

  ChangeFavoritesModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }

    status = map['status'];
    message = map['message'];
  }
}
