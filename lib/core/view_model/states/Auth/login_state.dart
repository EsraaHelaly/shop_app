import 'package:shop_app/model/login_model.dart';

abstract class LoginStates {}

class LoginInitiState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class GetLoginState extends LoginStates {
  final LoginModel loginModel;

  GetLoginState(this.loginModel);
}

class LoginErrorState extends LoginStates {
  final String error;

  LoginErrorState(this.error);
}
