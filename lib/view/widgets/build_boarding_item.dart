import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/model/boarding_model.dart';

import 'custom_text.dart';

class BuildBoardingItem extends StatelessWidget {
  const BuildBoardingItem({
    Key key,
    this.model,
  }) : super(key: key);

  final BoardingModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CustomText(
          text: 'Welcome',
          alignment: Alignment.center,
        ),
        const SizedBox(height: 10),
        Expanded(
          child: SvgPicture.asset(
            model.image,
            width: 240,
            height: 240,
          ),
        ),
        const SizedBox(height: 30),
        CustomText(
          text: model.title,
          alignment: Alignment.topLeft,
        ),
        const SizedBox(height: 10),
        CustomText(
          text: model.body,
          fontsize: 15.0,
          alignment: Alignment.topLeft,
        ),
      ],
    );
  }
}
