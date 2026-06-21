import 'package:expenz/models/expense_model.dart';
import 'package:expenz/models/income_model.dart';
import 'package:expenz/utils/colors.dart';
import 'package:expenz/utils/constants.dart';
import 'package:expenz/widget/category_card.dart';
import 'package:expenz/widget/pie_chart.dart';

import 'package:flutter/material.dart';

class BudgetPage extends StatefulWidget {
  final Map<expensecategory, double> expenseTotal;
  final Map<incomeCategory, double> incomeTotal;
  const BudgetPage({
    super.key,
    required this.expenseTotal,
    required this.incomeTotal,
  });

  @override
  State<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  int _selectedOption = 0;

  //methode to find the category color from the category
  Color getcategoryColor(dynamic category) {
    if (category is expensecategory) {
      return expenseCategoryColor[category]!;
    } else {
      return incomeCategoryColor[category]!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = _selectedOption == 0
        ? widget.expenseTotal
        : widget.incomeTotal;
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "Financial Report",
            style: TextStyle(fontWeight: .w600, fontSize: 18),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsetsGeometry.symmetric(
                  vertical: kDefalutPadding / 2,
                  horizontal: kDefalutPadding,
                ),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: .circular(100),
                    boxShadow: [
                      BoxShadow(color: kBlack.withOpacity(0.1), blurRadius: 20),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: .spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedOption = 0;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: .circular(100),
                            color: _selectedOption == 0 ? kRed : kWhite,
                          ),
                          child: Padding(
                            padding: .symmetric(vertical: 10, horizontal: 60),
                            child: Text(
                              "Expenses",
                              style: TextStyle(fontSize: 16, fontWeight: .w500),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedOption = 1;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: .circular(100),
                            color: _selectedOption == 1 ? kGreen : kWhite,
                          ),
                          child: Padding(
                            padding: .symmetric(vertical: 10, horizontal: 60),
                            child: Text(
                              "Income",
                              style: TextStyle(fontSize: 16, fontWeight: .w500),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              //pie chart
              Chart(
                expeneseCategoryTotal: widget.expenseTotal,
                incomeCategoryTotal: widget.incomeTotal,
                isExpense: _selectedOption == 0,
              ),
              SizedBox(height: 20),
              //list of categories
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,

                  shrinkWrap: true,
                  itemCount: data.length,

                  itemBuilder: (context, index) {
                    final categories = data.keys.toList()[index];
                    final total = data.values.toList()[index];
                    return CategoryCard(
                      title: categories.name,
                      amount: total,
                      total: data.values.reduce(
                        (Value, Element) => Value + Element,
                      ),
                      prograssColor: getcategoryColor(categories),
                      isExpense: _selectedOption == 0,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
