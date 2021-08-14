import 'package:flutter/material.dart';

import '../../constants.dart';
import 'custom_text.dart';

class AlreadyHaveAnAccount extends StatelessWidget {
  final String text;
  final String pageText;
  final Function onTap;

  const AlreadyHaveAnAccount({
    Key key,
    this.text,
    this.pageText,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText(
          text: text,
          fontsize: 17,
          alignment: Alignment.center,
        ),
        GestureDetector(
          onTap: onTap,
          child: CustomText(
            text: pageText,
            fontsize: 17,
            color: kprimaryColor,
            alignment: Alignment.center,
          ),
        ),
      ],
    );
  }
}
