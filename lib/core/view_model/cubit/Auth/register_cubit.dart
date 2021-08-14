import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/services/dio_helper.dart';
import 'package:shop_app/core/view_model/states/Auth/register_state.dart';
import 'package:shop_app/model/login_model.dart';

import '../../../../constants.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitiState());
  static RegisterCubit get(context) => BlocProvider.of(context);

  LoginModel loginModel;

  void userRegister({
    @required String email,
    @required String password,
    @required String name,
    @required String phone,
  }) {
    emit(RegisterLoadingState());

    DoiHelper.postData(url: register, data: {
      'email': email,
      'password': password,
      'phone': phone,
      'name': name,
    }).then((value) {
      loginModel = LoginModel.fromJson(value.data);

      emit(GetRegisterState(loginModel));
    }).catchError((error) {
      //print(error.toString());
      emit(RegisterErrorState(error.toString()));
    });
  }
}
