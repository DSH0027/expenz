import 'package:flutter/material.dart';

class UserDataScreens extends StatefulWidget {
  const UserDataScreens({super.key});

  @override
  State<UserDataScreens> createState() => _UserDataScreensState();
}

class _UserDataScreensState extends State<UserDataScreens> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("user data"),
    );
  }
}