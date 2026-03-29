import 'package:expenz/services/user_services.dart';
import 'package:expenz/utils/colors.dart';
import 'package:expenz/utils/constants.dart';
import 'package:expenz/widget/income_expence_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String username = "";

  @override
  void initState() {
    UserServices.getUserData().then((value) {
      if (value["username"] != null) {
        setState(() {
          username = value["username"]!;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height*0.3,
                decoration: BoxDecoration(
                  color: kMainColor.withOpacity(0.37),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(28),
                    bottomLeft: Radius.circular(28),
                  )
                ),
                child: Padding(
                  padding: const EdgeInsets.all(kDefalutPadding),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: .spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: kMainColor,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(color: kMainColor, width: 3),
                            ),
                  
                            child: ClipRRect(
                              borderRadius: BorderRadiusGeometry.circular(100),
                              child: Image.asset(
                                "assets/images/user.jpg",
                                width: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                  
                          Text(
                            "Welcome $username",
                            style: TextStyle(
                              fontWeight: .w500,
                              color: kBlack,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(width: 30),
                  
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.notifications),
                            color: kMainColor,
                            iconSize: 30,
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 46,
                      ),

                      Row(mainAxisAlignment: .spaceBetween,
                        children: [
                          IncomeExpenceCard(cardbgcolor: kGreen, Title: "Income", amount: 5000, image: "assets/images/income.png"),
                          IncomeExpenceCard(cardbgcolor: kRed, Title: "Expenses", amount: 1200, image: "assets/images/expense.png")
                        ],
                        
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
