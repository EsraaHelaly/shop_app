import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/core/services/dio_helper.dart';
import 'package:shop_app/core/view_model/states/Auth/login_state.dart';
import 'package:shop_app/model/login_model.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitiState());
  static LoginCubit get(context) => BlocProvider.of(context);

  LoginModel loginModel;

  void userLogin({@required String email, @required String password}) {
    emit(LoginLoadingState());

    DoiHelper.postData(url: login, data: {
      'email': email,
      'password': password,
    }).then((value) {
      loginModel = LoginModel.fromJson(value.data);

      emit(GetLoginState(loginModel));
    }).catchError((error) {
      //print(error.toString());
      emit(LoginErrorState(error.toString()));
    });
  }

 
}
