import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/helper/local_storage.dart';
import 'package:shop_app/model/boarding_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'auth/login_view.dart';
import 'widgets/build_boarding_item.dart';
import 'widgets/custom_text.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  var boardingController = PageController();

  final List<BoardingModel> boarding = [
    BoardingModel('images/shop1.svg', 'title1', 'body1'),
    BoardingModel('images/shop2.svg', 'title2', 'body2'),
    BoardingModel('images/shop3.svg', 'title3', 'body3'),
  ];

  bool isLast = false;

  void submit() {
    CashHelper.saveData(key: 'pageview', value: true).then((value) {
      if (value) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginView()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: () {
              submit();
            },
            child: const CustomText(
              text: 'Skip',
              fontsize: 20.0,
              color: kprimaryColor2,
              alignment: Alignment.center,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                  physics: const BouncingScrollPhysics(),
                  controller: boardingController,
                  itemBuilder: (context, index) =>
                      BuildBoardingItem(model: boarding[index]),
                  itemCount: boarding.length,
                  onPageChanged: (int index) {
                    if (index == boarding.length - 1) {
                      setState(() {
                        isLast = true;
                      });
                    } else {
                      setState(() {
                        isLast = false;
                      });
                    }
                  }),
            ),
            const SizedBox(height: 40),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SmoothPageIndicator(
                    controller: boardingController,
                    count: boarding.length,
                    effect: const ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: kprimaryColor2,
                      dotHeight: 10,
                      dotWidth: 10,
                      expansionFactor: 4,
                      spacing: 5.0,
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: FloatingActionButton(
                    backgroundColor: kprimaryColor2,
                    onPressed: () {
                      if (isLast) {
                        submit();
                      } else {
                        boardingController.nextPage(
                          duration: const Duration(milliseconds: 700),
                          curve: Curves.bounceInOut,
                        );
                      }
                    },
                    child: const Icon(Icons.arrow_forward_ios),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
