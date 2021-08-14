import 'package:shop_app/model/login_model.dart';

abstract class RegisterStates {}

class RegisterInitiState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class GetRegisterState extends RegisterStates {
  final LoginModel loginModel;

  GetRegisterState(this.loginModel);
}

class RegisterErrorState extends RegisterStates {
  final String error;

  RegisterErrorState(this.error);
}
