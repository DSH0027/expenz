import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserServices {
  static Future<void> storeUserDetails(
    String username,
    String email,
    String password,
    String confirmpasword,
    BuildContext context,
  ) async {

    //if the password and confirmed password are same ,saved the user details inside the app

    try {
      if (password != confirmpasword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "password and the confirmed password are not match with each",
          ),
        ),
      );
      return;
    }
      //create an instance from shared pref

      SharedPreferences prefs = await SharedPreferences.getInstance();
      //store the username and email as the key value pairs
      await prefs.setString("username", username);
      await prefs.setString("email", email);
      //show a message to the user that theres details has been saved
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("user details stored successfully")),
      );
    } catch (err) {
      err.toString();
    }
  }
  // check whether the username is saved in shared preferences
  static Future<bool>checkUserName()async{
    SharedPreferences pref=await SharedPreferences.getInstance();
    String? username=pref.getString('username');
    return username !=null;
  }

  static Future<Map<String,String>>getUserData()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();

    String? userName=prefs.getString("username");
    String? email=prefs.getString("email");

    return {"username":userName!,"email":email!};
  }

}
