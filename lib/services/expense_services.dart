import 'dart:convert';

import 'package:expenz/models/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenseServices {
  //expence list
  List<ExpenseModel> expensesList = [];

  //Definde the key for storing expenses in shared preferences
  static const String _expenseKey = 'expenses';

  //save the expenses to shared preferences
  Future<void> saveExpenses(ExpenseModel expense, BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? exsistingExpenses = prefs.getStringList(_expenseKey);
      //convert  the existing expenses to a list of expenses objects
      List<ExpenseModel> existingExpenseObjects = [];
      if (exsistingExpenses != null) {
        existingExpenseObjects = exsistingExpenses
            .map((e) => ExpenseModel.fromJSON(json.decode(e)))
            .toList();
      }
      //add the new expense to the list
      existingExpenseObjects.add(expense);

      //convert the list of expense objects back to a list of strings
      List<String> updatedExpenses = existingExpenseObjects
          .map((e) => json.encode(e.tojson()))
          .toList();

      //save the updated list of expenses to shared preferences
      await prefs.setStringList(_expenseKey, updatedExpenses);

      //show message
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Expense added succesfully"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error on adding expense"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  //load expenses from shared preferences
  Future<List<ExpenseModel>> loadExpenses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? exsistingExpenses = prefs.getStringList(_expenseKey);

    //convert the existing expenses to a list of expense objects
    List<ExpenseModel> loadedExpenses = [];
    if (exsistingExpenses != null) {
      loadedExpenses = exsistingExpenses
          .map((e) => ExpenseModel.fromJSON(json.decode(e)))
          .toList();
    }

    return loadedExpenses;
  }

  //delete the expense from shaed preferences from id
  Future<void> deleteExpenses(int id, BuildContext context) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      List<String>? exsistingExpenses = pref.getStringList(_expenseKey);

      List<ExpenseModel> existingExpenseObjects = [];
      if (exsistingExpenses != null) {
        existingExpenseObjects = exsistingExpenses
            .map((e) => ExpenseModel.fromJSON(json.decode(e)))
            .toList();
      }

      existingExpenseObjects.removeWhere((expens) => expens.id == id);

      List<String> updatedExpenses = existingExpenseObjects
          .map((e) => json.encode(e.tojson()))
          .toList();

      await pref.setStringList(_expenseKey, updatedExpenses);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Expense deleted successfully"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Error deleting expense"),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }
}
