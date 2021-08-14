import 'package:flutter/material.dart';
import 'package:shop_app/core/view_model/cubit/home_cubit.dart';

import '../../constants.dart';
import 'custom_text.dart';

Container buildProductListItem(
    {model, cubit, context, bool isOldPrice = true}) {
  return Container(
    height: 110,
    color: Colors.white,
    child: Row(
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Image(
              image: NetworkImage(model.image),
              height: 100,
              width: 200,
            ),
            if (model.discount != 0 && isOldPrice)
              Padding(
                padding: const EdgeInsets.only(left: 100.0),
                child: Container(
                  width: 100.0,
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
        const SizedBox(width: 20.0),
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomText(
                  text: model.name,
                  maxline: 2,
                  fontsize: 20.0,
                  alignment: Alignment.center,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  CustomText(
                    text: model.price.toString(),
                    fontsize: 20.0,
                    color: kprimaryColor,
                  ),
                  const SizedBox(width: 10.0),
                  if (model.discount != 0 && isOldPrice)
                    Text(
                      model.oldPrice.toString(),
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      HomeCubit.get(context).changeFavorites(model.id);
                    },
                    icon: CircleAvatar(
                      backgroundColor:
                          HomeCubit.get(context).favorites[model.id]
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
            ],
          ),
        ),
      ],
    ),
  );
}
