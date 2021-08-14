import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/view_model/cubit/home_cubit.dart';
import 'package:shop_app/core/view_model/states/home_states.dart';
import 'package:shop_app/view/widgets/build_catrgory_list.dart';
import 'package:shop_app/view/widgets/build_grid_view.dart';
import 'package:shop_app/view/widgets/carsouel_slider.dart';
import 'package:shop_app/view/widgets/custom_text.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
        listener: (BuildContext contex, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);
          return cubit.homeModel != null && cubit.categoriesModel != null
              ? Scaffold(
                  body: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        BuildCarouselSlider(homeModel: cubit.homeModel),
                        const SizedBox(height: 20.0),
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: CustomText(text: 'Categories'),
                        ),
                        const SizedBox(height: 20),
                        BuildCategoryListView(cubit: cubit),
                        const SizedBox(height: 20),
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: CustomText(text: 'Products'),
                        ),
                        BuildGridView(cubit: cubit),
                      ],
                    ),
                  ),
                )
              : const Center(child: CircularProgressIndicator());
        });
  }
}
