import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "Inter"),
      home: SafeArea(
        child: Scaffold(
          body: Center(
            child: Text("Hello flutter", style: TextStyle(fontSize: 20)),
          ),
        ),
      ),
    );
  }
}
