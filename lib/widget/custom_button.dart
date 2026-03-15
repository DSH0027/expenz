import 'package:expenz/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Color color;
  const CustomButton({super.key, required this.title, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.06,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: color,
      ),
      child: Center(
        child: Text(title, style: TextStyle(
          color: kWhite,
          fontSize: 16,
          fontWeight: .w400,
        ),),
      ),
    );
  }
}
