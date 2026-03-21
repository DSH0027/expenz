import 'package:expenz/screens/main_screen.dart';
import 'package:expenz/screens/onboardin_screen.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatefulWidget {
  final bool showMainscreen;
  const Wrapper({super.key, required this.showMainscreen});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return widget.showMainscreen
     ? MainScreen():OnboardinScreen()
    
    ;
  }
}