import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/services/dio_helper.dart';
import 'package:shop_app/core/view_model/states/search_states.dart';
import 'package:shop_app/model/search_model.dart';

import '../../../constants.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitiState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel searchModel;

  void getSearchData({@required String text}) {
    emit(SearchLoadingState());
    DoiHelper.postData(
      url: search,
      token: token,
      data: {'text': text},
    ).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      print('searchModel $searchModel');

      emit(SearchSucseesState());
    }).catchError((error) {
      print('error== ${error}');
      emit(SearchErrorState(error.toString()));
    });
  }
}
