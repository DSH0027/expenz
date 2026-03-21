import 'package:expenz/screens/main_screen.dart';
import 'package:expenz/services/user_services.dart';
import 'package:expenz/utils/colors.dart';
import 'package:expenz/utils/constants.dart';
import 'package:expenz/widget/custom_button.dart';
import 'package:flutter/material.dart';

class UserDataScreens extends StatefulWidget {
  const UserDataScreens({super.key});

  @override
  State<UserDataScreens> createState() => _UserDataScreensState();
}

class _UserDataScreensState extends State<UserDataScreens> {
  bool _rememberme = false;

  final _formkey = GlobalKey<FormState>();

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _userPassworController = TextEditingController();
  final TextEditingController _confirmPaaswordController =
      TextEditingController();

  @override
  void dispose() {
    _userNameController.dispose();
    _confirmPaaswordController.dispose();
    _confirmPaaswordController.dispose();
    _userEmailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(kDefalutPadding),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                SizedBox(height: 43),
                Text(
                  "Enter your\nPersonal Details",
                  style: TextStyle(fontSize: 36, fontWeight: .w500),
                ),
                SizedBox(height: 53),
                Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _userNameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter Your Name";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Name",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              width: 1.4,
                              color: Colors.black,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                      TextFormField(
                        controller: _userEmailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "please Enter Your Email";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Email",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              width: 1.4,
                              color: Colors.black,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                      TextFormField(
                        controller: _userPassworController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter A Valid password";
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Password",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              width: 1.4,
                              color: Colors.black,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                      TextFormField(
                        controller: _confirmPaaswordController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please Enter The Same password";
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: "Confirm password",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              width: 1.4,
                              color: Colors.black,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      SizedBox(height: 31),
                      Row(
                        mainAxisAlignment: .spaceBetween,
                        children: [
                          Text(
                            "Remember Me for the next time",
                            style: TextStyle(
                              color: kGrey,
                              fontSize: 16,
                              fontWeight: .w500,
                            ),
                          ),

                          Expanded(
                            child: Checkbox(
                              activeColor: kMainColor,
                              value: _rememberme,
                              onChanged: (value) {
                                setState(() {
                                  _rememberme = value!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 67),
                      GestureDetector(
                        onTap: () async {
                          if (_formkey.currentState!.validate()) {
                            String username = _userNameController.text;
                            String email = _userEmailController.text;
                            String password = _userPassworController.text;
                            String confirmpasword =
                                _confirmPaaswordController.text;

                            await UserServices.storeUserDetails(
                              username,
                              email,
                              password,
                              confirmpasword,
                              context,
                            );

                            if (context.mounted) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MainScreen(),
                                ),
                              );
                            }
                          }
                        },
                        child: CustomButton(title: "Next", color: kMainColor),
                      ),
                    ],
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
