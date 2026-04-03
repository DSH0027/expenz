import 'package:expenz/utils/colors.dart';
import 'package:flutter/material.dart';

enum expensecategory { Shopping, Subscriptions, Food, Health, Transport }

//category images
final Map<expensecategory, String> expenseCategoryImage = {
  expensecategory.Food: "assets/images/restaurant.png",
  expensecategory.Health: "assets/images/health.png",
  expensecategory.Shopping: "assets/images/bag.png",
  expensecategory.Transport: "assets/images/car.png",
  expensecategory.Subscriptions: "assets/images/bill.png",
};

//category colors
final Map<expensecategory, Color> expenseCategoryColor = {
  expensecategory.Food: kRed,
  expensecategory.Shopping: kYellow,
  expensecategory.Subscriptions: kMainColor,
  expensecategory.Health: kLightYellow,
  expensecategory.Transport: kOrange,
};

class ExpenseModel {
  final int id;
  final String Title;
  final expensecategory category;
  final DateTime date;
  final DateTime time;
  final String Description;
  final double amount;

  ExpenseModel({
    required this.id,
    required this.Title,
    required this.category,
    required this.date,
    required this.time,
    required this.Description,
    required this.amount,
  });

  Map<String, dynamic> tojson() {
    return {
      'id': id,
      'Title': Title,
      'category': category.index,
      'date': date.toIso8601String(),
      'time': time.toIso8601String(),
      'Description': Description,
      'amount': amount,
    };
  }

  factory ExpenseModel.fromJSON(Map<String, dynamic> json) {
    return ExpenseModel(
      id: json['id'],
      Title: json['Title'],
      category: expensecategory.values[json['category']],
      date: DateTime.parse(json['date']),
      time: DateTime.parse(json['time']),
      Description: json['Description'],
      amount: json['amount'],
    );
  }
}
