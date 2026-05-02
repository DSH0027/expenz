import 'package:expenz/models/expense_model.dart';
import 'package:expenz/models/income_model.dart';
import 'package:expenz/utils/colors.dart';
import 'package:expenz/utils/constants.dart';
import 'package:expenz/widget/expense_card.dart';
import 'package:expenz/widget/income_card.dart';
import 'package:flutter/material.dart';

class TransactionsPage extends StatefulWidget {
  final void Function(ExpenseModel) onDismisedExpense;
  final void Function(IncomeModel) onDismissedIncome;
  final List<ExpenseModel> expenceList;
  final List<IncomeModel> incomeList;
  const TransactionsPage({
    super.key,
    required this.expenceList,
    required this.onDismisedExpense,
    required this.incomeList, required this.onDismissedIncome,
  });

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsetsGeometry.all(kDefalutPadding),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  "See Your Financial Report",
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

                        widget.expenceList.isEmpty?Center(
                          child: Text("No expenses has added yet,\nadd some expenses to see",style: TextStyle(
                            fontSize: 18,
                            color: kBlack,
                            fontWeight: FontWeight.w300
                          ),),
                        ):
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
                SizedBox(height: 26),
                Text(
                  "Incomes",
                  style: TextStyle(
                    color: kBlack,
                    fontSize: 18,
                    fontWeight: .w600,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.35,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        widget.incomeList.isEmpty?Center(
                          child: Text("No income has added yet,\nadd some incomes to see",style: TextStyle(
                            fontSize: 18,
                            color: kBlack,
                            fontWeight: FontWeight.w300
                          ),),
                        ):
                        ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: widget.incomeList.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final income = widget.incomeList[index];
                            return Dismissible(
                              key: ValueKey(income),
                              direction: DismissDirection.startToEnd,
                              onDismissed: (direction) {
                                widget.onDismissedIncome(income);
                              },
                              child: IncomeCard(
                                Title: income.Title,
                                date: income.date,
                                amount: income.amount,
                                category: income.category,
                                description: income.Description,
                                time: income.time,
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
      ),
    );
  }
}
