import 'package:expenz/models/expense_model.dart';
import 'package:expenz/utils/colors.dart';
import 'package:expenz/utils/constants.dart';
import 'package:expenz/widget/expense_card.dart';
import 'package:flutter/material.dart';

class TransactionsPage extends StatefulWidget {
  final void Function(ExpenseModel) onDismisedExpense;
  final List<ExpenseModel> expenceList;
  const TransactionsPage({super.key, required this.expenceList, required this.onDismisedExpense});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(kDefalutPadding),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Text(
                "See Your FInancial Report",
                style: TextStyle(
                  color: kMainColor,
                  fontSize: 20,
                  fontWeight: .w600,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Expenses",
                style: TextStyle(
                  color: kBlack,
                  fontSize: 18,
                  fontWeight: .w600,
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.35,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: widget.expenceList.length,
                        itemBuilder: (context, index) {
                          final expense = widget.expenceList[index];
                          return Dismissible(
                            key: ValueKey(expense),
                            direction: DismissDirection.startToEnd,
                            onDismissed: (direction) {
                              setState(() {
                                widget.onDismisedExpense(expense);
                              });
                            },

                            child: ExpenseCard(
                              Title: expense.Title,
                              date: expense.date,
                              amount: expense.amount,
                              category: expense.category,
                              description: expense.Description,
                              time: expense.time,
                            ),
                          );
                        },
                      ),
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
