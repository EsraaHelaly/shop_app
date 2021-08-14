import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/core/services/dio_helper.dart';
import 'package:shop_app/core/view_model/states/home_states.dart';
import 'package:shop_app/helper/local_storage.dart';
import 'package:shop_app/model/categories_model.dart';
import 'package:shop_app/model/change_favorites_model.dart';
import 'package:shop_app/model/favorites_model.dart';
import 'package:shop_app/model/home_model.dart';
import 'package:shop_app/model/login_model.dart';
import 'package:shop_app/view/NavBarViews/favorites.dart';
import 'package:shop_app/view/NavBarViews/products.dart';
import 'package:shop_app/view/NavBarViews/settings.dart';
import 'package:shop_app/view/NavBarViews/categories.dart';
import 'package:shop_app/view/auth/login_view.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitiState());

  static HomeCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> views = [
    const ProductsView(),
    const CategoriesView(),
    const FavoritesView(),
    SettingsView(),
  ];

  List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.category), label: 'Category'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.favorite), label: 'Favorite'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.settings), label: 'Settings'),
  ];

  void changeIndex(int index) {
    currentIndex = index;
    emit(NavBarState());
  }

  HomeModel homeModel;
  CategoriesModel categoriesModel;
  FavoritesModel favoritesModel;
  LoginModel userModel;

  ChangeFavoritesModel changeFavoritesModel;
  Map<int, bool> favorites = {};
  void getHomeData() {
    emit(HomeLoadingState());

    DoiHelper.getData(url: home, token: token).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel.data.products.forEach((element) {
        favorites.addAll({
          element.id: element.inFavorite,
        });
      });
      // print(favorites.toString());
      // print(' status===${homeModel.status}');

      emit(HomeSucseesState());
    }).catchError((error) {
      // print('error== ${error}');
      emit(HomeErrorState(error.toString()));
    });
  }

  void getCategoriesData() {
    DoiHelper.getData(url: categories, token: token).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      // print(' status category===${categoriesModel.status}');

      emit(CategoriesSucseesState());
    }).catchError((error) {
      // print('error== $error');
      emit(CategoriesErrorState(error.toString()));
    });
  }

  void getFavoritesData() {
    emit(FavoritesLoadingState());

    DoiHelper.getData(url: favorite, token: token).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);

      // print(' status fav ===${favoritesModel.status}');

      emit(FavoritesSucseesState());
    }).catchError((error) {
      // print('error== $error');
      emit(FavoritesErrorState(error.toString()));
    });
  }

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId];
    emit(ChangeFavoritesSucseesState());

    DoiHelper.postData(
      url: favorite,
      data: {'product_id': productId},
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);

      if (!changeFavoritesModel.status) {
        favorites[productId] = !favorites[productId];
      } else {
        getFavoritesData();
      }

      emit(ChangeFavoritesSucseesState());
    }).catchError((error) {
      favorites[productId] = !favorites[productId];

      // print('error== $error');
      emit(ChangeFavoritesErrorState(error.toString()));
    });
  }

  void getUserData() {
    emit(UserProfileLoadingState());
    DoiHelper.getData(url: profile, token: token).then((value) {
      userModel = LoginModel.fromJson(value.data);

      // print(' status userdata===${userModel.data.name}');

      emit(UserProfileSucseesState());
    }).catchError((error) {
      // print('error== $error');
      emit(UserProfileErrorState(error.toString()));
    });
  }

  void logOut(BuildContext context) {
    CashHelper.removeData(key: 'token').then((value) =>
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginView())));
  }

  void updateUserData(
      {@required String name, @required String email, @required String phone}) {
    emit(UpdateUserProfileLoadingState());
    DoiHelper.putData(
      url: updateProfile,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);

      emit(UpdateUserProfileSucseesState());
    }).catchError((error) {
      // print('error== $error');
      emit(UpdateUserProfileErrorState(error.toString()));
    });
  }
}
