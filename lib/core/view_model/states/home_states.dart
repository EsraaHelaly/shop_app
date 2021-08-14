abstract class HomeStates {}

class HomeInitiState extends HomeStates {}

class NavBarState extends HomeStates {}

class HomeLoadingState extends HomeStates {}

class HomeSucseesState extends HomeStates {}

class HomeErrorState extends HomeStates {
  final String error;

  HomeErrorState(this.error);
}

class CategoriesSucseesState extends HomeStates {}

class CategoriesErrorState extends HomeStates {
  final String error;

  CategoriesErrorState(this.error);
}

class ChangeFavoritesSucseesState extends HomeStates {}

class ChangeFavoritesErrorState extends HomeStates {
  final String error;

  ChangeFavoritesErrorState(this.error);
}

class FavoritesLoadingState extends HomeStates {}

class FavoritesSucseesState extends HomeStates {}

class FavoritesErrorState extends HomeStates {
  final String error;

  FavoritesErrorState(this.error);
}


class UserProfileLoadingState extends HomeStates {}

class UserProfileSucseesState extends HomeStates {}

class UserProfileErrorState extends HomeStates {
  final String error;

  UserProfileErrorState(this.error);
}




class UpdateUserProfileLoadingState extends HomeStates {}

class UpdateUserProfileSucseesState extends HomeStates {}

class UpdateUserProfileErrorState extends HomeStates {
  final String error;

  UpdateUserProfileErrorState(this.error);
}
