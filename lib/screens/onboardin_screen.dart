import 'package:expenz/data/onboarding_data.dart';
import 'package:expenz/screens/onboarding/front_page.dart';
import 'package:expenz/screens/onboarding/shared_onboarding_screens.dart';
import 'package:expenz/screens/user_data_screen.dart';
import 'package:expenz/utils/colors.dart';
import 'package:expenz/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardinScreen extends StatefulWidget {
  const OnboardinScreen({super.key});

  @override
  State<OnboardinScreen> createState() => _OnboardinScreenState();
}

class _OnboardinScreenState extends State<OnboardinScreen> {
  final PageController _controller = PageController();
  bool showdetailpage=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                PageView(
                  controller: _controller,
                  onPageChanged: (Index) {
                    setState(() {
                      showdetailpage=Index==3;
                    });
                  },
                  children: [
                    FrontPage(),
                    SharedOnboardingScreens(
                      image: OnboardingData.onboardingDataList[0].image,
                      title: OnboardingData.onboardingDataList[0].title,
                      description:
                          OnboardingData.onboardingDataList[0].description,
                    ),
                    SharedOnboardingScreens(
                      image: OnboardingData.onboardingDataList[1].image,
                      title: OnboardingData.onboardingDataList[1].title,
                      description:
                          OnboardingData.onboardingDataList[1].description,
                    ),
                    SharedOnboardingScreens(
                      image: OnboardingData.onboardingDataList[2].image,
                      title: OnboardingData.onboardingDataList[2].title,
                      description:
                          OnboardingData.onboardingDataList[2].description,
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment(0, 0.55),
                  child: SmoothPageIndicator(
                    controller: _controller,
                    count: 4,
                    effect: WormEffect(
                      activeDotColor: kMainColor,
                      dotColor: kLightGrey,
                    ),
                  ),
                ),

                Positioned(
                  bottom: 76,
                  left: 20,
                  right: 30,
                  child:!showdetailpage? GestureDetector(
                    onTap: () {
                      _controller.animateToPage(
                        _controller.page!.toInt() +1,
                        duration: Duration(milliseconds: 400),
                        curve: Curves.easeInOut
                      );
                    },
                    child: CustomButton(title:!showdetailpage?"next":"Get started", color: kMainColor),
                  ):
                   GestureDetector(
                    onTap: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context)=>UserDataScreens()));
                    },
                    child: CustomButton(title:!showdetailpage?"next":"Get started", color: kMainColor),
                  )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
