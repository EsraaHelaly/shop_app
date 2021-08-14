import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/constants.dart';

import 'package:shop_app/core/view_model/cubit/Auth/login_cubit.dart';
import 'package:shop_app/core/view_model/states/Auth/login_state.dart';
import 'package:shop_app/helper/local_storage.dart';
import 'package:shop_app/view/auth/register_view.dart';
import 'package:shop_app/view/widgets/already_have_account.dart';
import 'package:shop_app/view/widgets/custom_button.dart';
import 'package:shop_app/view/widgets/custom_text.dart';
import 'package:shop_app/view/widgets/custom_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../NavBarViews/home_view.dart';

class LoginView extends StatelessWidget {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  LoginView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginStates>(
        listener: (BuildContext context, state) {
      if (state is GetLoginState) {
        if (state.loginModel.status) {
          CashHelper.saveData(key: 'token', value: state.loginModel.data.token)
              .then((value) {
            token = state.loginModel.data.token;
            if (value) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const HomeView()));
            }
          });

          Fluttertoast.showToast(
              msg: state.loginModel.message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          Fluttertoast.showToast(
              msg: state.loginModel.message,
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      }
    }, builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const CustomText(text: "LOGIN", fontsize: 33),
                    const SizedBox(height: 10),
                    const CustomText(
                      text: 'Sign in to continue',
                      fontsize: 18,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 70),
                    CustomTextField(
                      text: 'Email',
                      hinttext: 'enter your email',
                      textType: TextInputType.emailAddress,
                      passwordVisible: false,
                      onsaved: (value) {
                        emailController.text = value;
                      },
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'must enter this field';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    CustomTextField(
                      text: 'Password',
                      hinttext: 'enter your password',
                      textType: TextInputType.visiblePassword,
                      isPassword: true,
                      onsaved: (value) {
                        passwordController.text = value;
                      },
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'must enter this field';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    const CustomText(
                      text: 'forget password?',
                      fontsize: 14,
                      alignment: Alignment.topRight,
                    ),
                    const SizedBox(height: 40),
                    state is! LoginLoadingState
                        ? CustomButton(
                            text: 'SIGN IN',
                            press: () {
                              _formkey.currentState.save();
                              if (_formkey.currentState.validate()) {
                                LoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                          )
                        : const Center(child: CircularProgressIndicator()),
                    const SizedBox(height: 20),
                    Hero(
                      tag: 'user',
                      child: AlreadyHaveAnAccount(
                        text: "Don't have an Account? ",
                        pageText: "Sign Up",
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterView()));
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
                    const CustomText(
                      text: "-OR-",
                      fontsize: 17,
                      alignment: Alignment.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
