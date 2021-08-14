import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/view_model/cubit/home_cubit.dart';
import 'package:shop_app/core/view_model/states/home_states.dart';
import 'package:shop_app/view/widgets/build_product_list_item.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (BuildContext contex, state) {},
        builder: (context, state) {
          HomeCubit cubit = HomeCubit.get(context);
          return state is! FavoritesLoadingState
              ? Scaffold(
                  body: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) => buildProductListItem(
                          model: cubit.favoritesModel.data.data[index].product,
                          cubit: cubit,
                          context: context),
                      separatorBuilder: (context, index) =>
                          const Divider(color: Colors.grey, height: 30.0),
                      itemCount: cubit.favoritesModel.data.data.length))
              : const Center(child: CircularProgressIndicator());
        });
  }
}
