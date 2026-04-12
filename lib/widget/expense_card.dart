import 'package:expenz/models/expense_model.dart';
import 'package:expenz/utils/colors.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseCard extends StatelessWidget {
  final String Title;
  final DateTime date;
  final double amount;
  final expensecategory category;
  final String description;
  final DateTime time;

  const ExpenseCard({
    super.key,
    required this.Title,
    required this.date,
    required this.amount,
    required this.category,
    required this.description,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: kGrey.withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: expenseCategoryColor[category]!.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                expenseCategoryImage[category]!,
                width: 30,
                height: 30,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(Title, style: TextStyle(fontSize: 18, fontWeight: .w500)),
              SizedBox(
                width: MediaQuery.of(context).size.width*0.4,
                child: Text(
                  description,
                  style: TextStyle(color: kGrey, fontSize: 13, fontWeight: .w500),
                ),
              ),
              
            ],
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text("-\$${amount.toStringAsFixed(2)}", style: TextStyle(fontSize: 18, fontWeight: .bold,color: kRed)),
              Text(
                DateFormat.jm().format(date),
                style: TextStyle(color: kGrey, fontSize: 13, fontWeight: .w500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
