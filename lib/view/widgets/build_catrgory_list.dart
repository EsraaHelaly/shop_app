import 'package:flutter/material.dart';
import 'package:shop_app/core/view_model/cubit/home_cubit.dart';

import 'custom_text.dart';

class BuildCategoryListView extends StatelessWidget {
  const BuildCategoryListView({
    Key key,
    @required this.cubit,
  }) : super(key: key);

  final HomeCubit cubit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[200],
                  image: DecorationImage(
                    image: NetworkImage(
                        cubit.categoriesModel.data.data[index].image),
                  ),
                ),
                height: 100,
                width: 100,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomText(
                  text: cubit.categoriesModel.data.data[index].name,
                  alignment: Alignment.center,
                  fontsize: 20.0,
                ),
              ),
            ],
          ),
        ),
        separatorBuilder: (context, index) => const SizedBox(height: 10.0),
        itemCount: cubit.categoriesModel.data.data.length,
      ),
    );
  }
}
