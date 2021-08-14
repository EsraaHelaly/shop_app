import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/core/view_model/cubit/home_cubit.dart';

import 'custom_text.dart';

class BuildGridView extends StatelessWidget {
  const BuildGridView({
    Key key,
    @required this.cubit,
  }) : super(key: key);

  final HomeCubit cubit;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        shrinkWrap: true,
        crossAxisSpacing: 1.0,
        mainAxisSpacing: 1.0,
        childAspectRatio: 1 / 1.60,
        children: List.generate(
          cubit.homeModel.data.products.length,
          (index) => Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Image(
                      image: NetworkImage(
                          cubit.homeModel.data.products[index].image),
                      height: 200,
                      width: double.infinity,
                    ),
                    if (cubit.homeModel.data.products[index].discount != 0)
                      Padding(
                        padding: const EdgeInsets.only(right: 90.0),
                        child: Container(
                          width: 120.0,
                          height: 20.0,
                          padding: const EdgeInsets.all(2),
                          color: Colors.red,
                          child: const CustomText(
                            text: 'Discount',
                            color: Colors.black,
                            fontsize: 15.0,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 20.0),
                CustomText(
                  text: cubit.homeModel.data.products[index].name,
                  maxline: 2,
                  fontsize: 20.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      CustomText(
                        text:
                            '${cubit.homeModel.data.products[index].price.round()}',
                        fontsize: 20.0,
                      ),
                      const SizedBox(width: 10.0),
                      if (cubit.homeModel.data.products[index].discount != 0)
                        Text(
                          '${cubit.homeModel.data.products[index].oldPrice.round()}',
                          style: const TextStyle(
                            fontSize: 20.0,
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          cubit.changeFavorites(
                              cubit.homeModel.data.products[index].id);
                        },
                        icon: CircleAvatar(
                          backgroundColor: cubit.favorites[
                                  cubit.homeModel.data.products[index].id]
                              ? kprimaryColor
                              : Colors.grey,
                          child: const Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
