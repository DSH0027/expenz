import 'package:expenz/utils/colors.dart';
import 'package:expenz/utils/constants.dart';
import 'package:flutter/material.dart';

class SharedOnboardingScreens extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  const SharedOnboardingScreens({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(kDefalutPadding),
      child: Column(
    
        children: [
          SizedBox(
            height: 83,
          ),
          Image.asset(image, width: 312, height: 312, fit: BoxFit.cover),
          SizedBox(height: 23),
          Text(
            title,
            style: TextStyle(fontSize: 32, fontWeight: .bold, color: kBlack),
          ),
          SizedBox(height: 17),
          Text(
            description,
            style: TextStyle(color: kGrey, fontSize: 16, fontWeight: .w400),
          ),
        ],
      ),
    );
  }
}
