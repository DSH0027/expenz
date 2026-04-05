import 'dart:convert';

import 'package:expenz/models/income_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IncomeServices {
  //income List
  List<IncomeModel> incomeList = [];

  //defines the key for storing incomes in shared preferences
  static const String _incomeKey = 'income';

  Future<void> saveIncome(IncomeModel income, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? existingincome = prefs.getStringList(_incomeKey);

      //convert the exisiting json list into a dart oblect list
      List<IncomeModel> existingIncomeObjects = [];
      if (existingincome != null) {
        existingIncomeObjects = existingincome
            .map((e) => IncomeModel.fromJSON(json.decode(e)))
            .toList();
      }
      //add the new icome into the income object list
      existingIncomeObjects.add(income);

      //convert the list of objects back to list of strings
      List<String> updatedIncome = existingIncomeObjects
          .map((e) => json.encode(e.tojson()))
          .toList();

      //save the updated list into shared preferences
      await prefs.setStringList(_incomeKey, updatedIncome);

      //show message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Income saved successfully"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error on adding income"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  //load income from shared preferences
  Future<List<IncomeModel>> loadIncome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? existingincome = prefs.getStringList(_incomeKey);

    //load the existing incomes from shared preferences
    List<IncomeModel> loadedIncome = [];
    if (existingincome != null) {
      existingincome.map((e) => IncomeModel.fromJSON(json.decode(e))).toList();
    }

    return loadedIncome;
  }
}
