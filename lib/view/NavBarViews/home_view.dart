import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/view_model/cubit/home_cubit.dart';
import 'package:shop_app/core/view_model/states/home_states.dart';

import 'package:shop_app/view/search_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (BuildContext contex, state) {},
        builder: (context, state) {
          HomeCubit cubit = HomeCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.white,
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  SearchView()));
                  },
                  icon: const Icon(Icons.search),
                ),
              ],
            ),
            body: cubit.views[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              items: cubit.items,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },
            ),
          );
        });
  }
}
