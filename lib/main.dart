import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/services/dio_helper.dart';
import 'package:shop_app/helper/local_storage.dart';
import 'package:shop_app/view/NavBarViews/home_view.dart';

import 'constants.dart';
import 'core/view_model/cubit/Auth/login_cubit.dart';
import 'core/view_model/cubit/Auth/register_cubit.dart';
import 'core/view_model/cubit/home_cubit.dart';
import 'core/view_model/cubit/search_cubit.dart';
import 'view/auth/login_view.dart';
import 'view/onboarding_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DoiHelper.init();
  await CashHelper.init();

  Widget widget;
  bool pageView = CashHelper.getData(key: 'pageview');
  token = CashHelper.getData(key: 'token');
  print('token $token');

  if (pageView != null) {
    if (token != null) {
      widget = const HomeView();
    } else {
      widget = LoginView();
    }
  } else {
    widget = const OnBoardingView();
  }

  runApp(MyApp(widget: widget));
}

class MyApp extends StatelessWidget {
  final Widget widget;
  const MyApp({Key key, this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => LoginCubit()),
        BlocProvider(create: (BuildContext context) => RegisterCubit()),
        BlocProvider(create: (BuildContext context) => SearchCubit()),
        BlocProvider(
            create: (BuildContext context) => HomeCubit()
              ..getHomeData()
              ..getCategoriesData()
              ..getFavoritesData()
              ..getUserData()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0.0,
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
            iconTheme: IconThemeData(
              color: Colors.black,
              size: 35.0,
            ),
          ),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              selectedItemColor: kprimaryColor,
              unselectedItemColor: Colors.grey,
              elevation: 50.0),
        ),
        home: widget,
      ),
    );
  }
}
