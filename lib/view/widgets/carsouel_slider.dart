import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/model/home_model.dart';

class BuildCarouselSlider extends StatelessWidget {
  const BuildCarouselSlider({
    Key key,
    this.homeModel,
  }) : super(key: key);

  final HomeModel homeModel;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: homeModel.data.banners
          .map((e) => Image(image: NetworkImage(e.image)))
          .toList(),
      options: CarouselOptions(
        height: 250.0,
        initialPage: 0,
        viewportFraction: 1.0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
