import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/core/view_model/cubit/home_cubit.dart';
import 'package:shop_app/core/view_model/states/home_states.dart';
import 'package:shop_app/view/widgets/custom_button.dart';
import 'package:shop_app/view/widgets/custom_text.dart';
import 'package:shop_app/view/widgets/custom_text_field.dart';

class SettingsView extends StatelessWidget {
  SettingsView({Key key}) : super(key: key);
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (BuildContext contex, state) {},
        builder: (context, state) {
          var model = HomeCubit.get(context).userModel;
          nameController.text = model.data.name;
          emailController.text = model.data.email;
          phoneController.text = model.data.phone;

          return model != null
              ? Scaffold(
                  resizeToAvoidBottomInset: false,
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 80.0,
                        // child: Image.network(''),
                      ),
                      const SizedBox(height: 20.0),
                      CustomText(
                        text: nameController.text,
                        alignment: Alignment.center,
                      ),
                      const SizedBox(height: 40.0),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Card(
                          elevation: 1,
                          child: ListTile(
                            title: CustomText(
                              text: emailController.text,
                              fontsize: 20.0,
                            ),
                            leading:
                                const Icon(Icons.email, color: kprimaryColor),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Card(
                          elevation: 1,
                          child: ListTile(
                            title: CustomText(
                              text: phoneController.text,
                              fontsize: 20.0,
                            ),
                            leading:
                                const Icon(Icons.phone, color: kprimaryColor),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 120.0),
                        child: TextButton.icon(
                          icon: const Icon(Icons.edit, color: kprimaryColor),
                          label: const CustomText(
                            text: 'Edit Profile',
                            color: kprimaryColor,
                            fontsize: 20.0,
                          ),
                          onPressed: () {
                            buildBottomSheet(context, state);
                          },
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 120, right: 120, top: 110),
                        child: CustomButton(
                          text: 'LogOut',
                          press: () {
                            HomeCubit.get(context).logOut(context);
                          },
                        ),
                      ),
                    ],
                  ),
                )
              : const Center(child: CircularProgressIndicator());
        });
  }

  PersistentBottomSheetController<dynamic> buildBottomSheet(
      BuildContext context, HomeStates state) {
    return showBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
            width: double.infinity,
            height: 500,
            child: SingleChildScrollView(
              child: Form(
                key: _formkey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const CustomText(
                        text: 'Edit your Profile here',
                        fontsize: 18,
                        color: Colors.black,
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
                      CustomButton(
                        text: 'Edit',
                        press: () {
                          _formkey.currentState.save();
                          if (_formkey.currentState.validate()) {
                            HomeCubit.get(context).updateUserData(
                              name: nameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                            );
                            Navigator.pop(context);
                          }
                        },
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
