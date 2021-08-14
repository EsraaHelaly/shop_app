abstract class SearchStates {}

class SearchInitiState extends SearchStates {}



class SearchLoadingState extends SearchStates {}

class SearchSucseesState extends SearchStates {}

class SearchErrorState extends SearchStates {
  final String error;

  SearchErrorState(this.error);
}