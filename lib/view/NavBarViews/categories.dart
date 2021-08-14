import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/core/view_model/cubit/home_cubit.dart';
import 'package:shop_app/core/view_model/states/home_states.dart';
import 'package:shop_app/model/categories_model.dart';
import 'package:shop_app/view/widgets/custom_text.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);

        return Scaffold(
            body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => buildCategoryItem(
                  model: cubit.categoriesModel.data.data[index]),
              separatorBuilder: (context, index) => SizedBox(height: 10.0),
              itemCount: cubit.categoriesModel.data.data.length),
        ));
      },
    );
  }

  Padding buildCategoryItem({DataModel model}) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: NetworkImage(model.image),
              ),
            ),
            height: 110,
            width: 110,
          ),
          const SizedBox(width: 20),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0),
            child: CustomText(
              text: model.name,
              alignment: Alignment.topCenter,
              fontsize: 20.0,
            ),
          ),
          const Spacer(),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 30.0),
            child: IconButton(
                onPressed: null, icon: Icon(Icons.arrow_forward_ios_rounded)),
          ),
        ],
      ),
    );
  }
}
