import 'package:expenz/utils/colors.dart';
import 'package:flutter/material.dart';

class FrontPage extends StatelessWidget {
  const FrontPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: .center,
      children: [
        Image.asset("assets/images/logo.png",width: 100,fit: BoxFit.cover,),
        SizedBox(
          height: 20,
        ),
        Text("Expenz",style: TextStyle(
          color:kMainColor,
          fontSize: 56,
          fontWeight: .bold
        ),)

      ],
    );
  }
}