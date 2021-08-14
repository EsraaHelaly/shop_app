import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/core/view_model/cubit/Auth/register_cubit.dart';
import 'package:shop_app/core/view_model/states/Auth/register_state.dart';
import 'package:shop_app/helper/local_storage.dart';
import 'package:shop_app/view/NavBarViews/home_view.dart';
import 'package:shop_app/view/widgets/already_have_account.dart';
import 'package:shop_app/view/widgets/custom_button.dart';
import 'package:shop_app/view/widgets/custom_text.dart';
import 'package:shop_app/view/widgets/custom_text_field.dart';

import '../../constants.dart';
import 'login_view.dart';

class RegisterView extends StatelessWidget {
  RegisterView({Key key}) : super(key: key);

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (BuildContext context, state) {
      if (state is GetRegisterState) {
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
          leading: GestureDetector(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginView()));
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 30.0,
            ),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formkey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const CustomText(text: "SIGN UP", fontsize: 33),
                    const SizedBox(height: 10),
                    const CustomText(
                      text: 'Sign UP to continue',
                      fontsize: 18,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 50),
                    CustomTextField(
                      text: 'Name',
                      hinttext: 'enter your name',
                      passwordVisible: false,
                      onsaved: (value) {
                        nameController.text = value;
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
                      passwordVisible: true,
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
                    CustomTextField(
                      text: 'Phone',
                      hinttext: 'enter your phone',
                      textType: TextInputType.number,
                      passwordVisible: false,
                      onsaved: (value) {
                        phoneController.text = value;
                      },
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'must enter this field';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 40),
                    state is! RegisterLoadingState
                        ? CustomButton(
                            text: 'SIGN IN',
                            press: () {
                              _formkey.currentState.save();
                              if (_formkey.currentState.validate()) {
                                RegisterCubit.get(context).userRegister(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                          )
                        : const Center(child: CircularProgressIndicator()),
                    const SizedBox(height: 50),
                    Hero(
                      tag: 'user',
                      child: AlreadyHaveAnAccount(
                        text: "Already have an Account? ",
                        pageText: "Login",
                        onTap: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginView()));
                        },
                      ),
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
