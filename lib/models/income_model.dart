import 'package:expenz/utils/colors.dart';
import 'package:flutter/material.dart';

enum incomeCategory { freelance, salary, passive, sales }

//category images
final Map<incomeCategory, String> incomecategoryImage = {
  incomeCategory.freelance: "assets/images/freelance.png",
  incomeCategory.salary: "assets/images/salary.png",
  incomeCategory.sales: "assets/images/salary.png",
  incomeCategory.passive: "assets/images/salary.png",
};

//category colors
final Map<incomeCategory, Color> incomeCategoryColor = {
  incomeCategory.freelance: kBlack,
  incomeCategory.salary: kGreen,
  incomeCategory.sales: kGreen,
  incomeCategory.passive: kBlack,
};

class IncomeModel {
  final int id;
  final String Title;
  final incomeCategory category;
  final DateTime date;
  final DateTime time;
  final String Description;
  final double amount;

  IncomeModel({
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

  factory IncomeModel.fromJSON(Map<String, dynamic> json) {
    return IncomeModel(
      id: json['id'],
      Title: json['Title'],
      category: incomeCategory.values[json['category']],
      date: DateTime.parse(json['date']),
      time: DateTime.parse(json['time']),
      Description: json['Description'],
      amount: json['amount'],
    );
  }
}
