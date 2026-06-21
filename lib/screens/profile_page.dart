import 'package:expenz/screens/onboardin_screen.dart';
import 'package:expenz/services/expense_services.dart';
import 'package:expenz/services/income_services.dart';
import 'package:expenz/services/user_services.dart';
import 'package:expenz/utils/colors.dart';
import 'package:expenz/utils/constants.dart';
import 'package:expenz/widget/profile_card.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String username = "";
  String email = "";
  @override
  void initState() {
    super.initState();
    UserServices.getUserData().then((value) {
      if (value["username"] != null && value["email"] != null) {
        setState(() {
          username = value["username"]!;
          email = value["email"]!;
        });
      }
    });
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: kWhite,
      context: context,
      builder: (context) {
        return Container(
          height: 200,
          padding: EdgeInsets.all(kDefalutPadding),
          child: Column(
            mainAxisAlignment: .center,
            crossAxisAlignment: .center,
            children: [
              Text(
                "Are you sure you want to log out",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: .w500,
                  color: kBlack,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: .spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(kGreen),
                    ),
                    onPressed: () async {
                      //clear the user data
                      await UserServices.clearUserData();
                      if (context.mounted) {
                        //clear all the user expenses
                        await ExpenseServices().deleteAllExpenses(context);
                        //clear all the user incomes
                        await IncomeServices().deleteAllIncome(context);
                      }
                      //navigate to the onboard screen
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>OnboardinScreen()), (route)=>false);
                    },
                    child: Text(
                      "Yes",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: .w500,
                        color: kWhite,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(kRed),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "No",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: .w500,
                        color: kWhite,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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

                    Column(
                      crossAxisAlignment: .start,
                      children: [
                        Text(
                          "Welcome $username",
                          style: TextStyle(
                            fontWeight: .w500,
                            color: kBlack,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          " $email",
                          style: TextStyle(
                            fontWeight: .w400,
                            color: kGrey,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 30),

                    IconButton(
                      onPressed: () {},
                      icon: Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: kMainColor.withOpacity(0.2),
                        ),
                        child: Icon(Icons.edit),
                      ),
                      color: kMainColor,
                      iconSize: 30,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ProfileCard(
                  icon: Icons.wallet,
                  title: "My wallet",
                  color: kMainColor,
                ),
                ProfileCard(
                  icon: Icons.settings,
                  title: "Settings",
                  color: kMainColor,
                ),
                ProfileCard(
                  icon: Icons.download,
                  title: "Export Data",
                  color: kMainColor,
                ),
                Divider(),
                GestureDetector(
                  onTap: () {
                    _showBottomSheet(context);
                  },
                  child: ProfileCard(
                    icon: Icons.logout,
                    title: "Log Out",
                    color: kRed,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
