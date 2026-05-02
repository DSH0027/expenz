import 'package:expenz/models/expense_model.dart';
import 'package:expenz/models/income_model.dart';
import 'package:expenz/services/user_services.dart';
import 'package:expenz/utils/colors.dart';
import 'package:expenz/utils/constants.dart';
import 'package:expenz/widget/expense_card.dart';
import 'package:expenz/widget/income_expence_card.dart';
import 'package:expenz/widget/line_chart.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final List<ExpenseModel> expenceList;
  final List<IncomeModel> incomeList;
  const HomePage({super.key, required this.expenceList, required this.incomeList});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String username = "";
  double expenseTotal=0;
  double incomeTotal=0;

  @override
  void initState() {
    UserServices.getUserData().then((value) {
      if (value["username"] != null) {
        setState(() {
          username = value["username"]!;
        });
      }
    });
    setState(() {
      for(var i =0;i<widget.expenceList.length;i++){
        expenseTotal+=widget.expenceList[i].amount;
      }
       for(var i =0;i<widget.incomeList.length;i++){
        incomeTotal+=widget.incomeList[i].amount;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(
                  color: kMainColor.withOpacity(0.37),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(28),
                    bottomLeft: Radius.circular(28),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(kDefalutPadding),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: .spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: kMainColor,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(color: kMainColor, width: 3),
                            ),

                            child: ClipRRect(
                              borderRadius: BorderRadiusGeometry.circular(100),
                              child: Image.asset(
                                "assets/images/user.jpg",
                                width: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 20),

                          Text(
                            "Welcome $username",
                            style: TextStyle(
                              fontWeight: .w500,
                              color: kBlack,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(width: 30),

                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.notifications),
                            color: kMainColor,
                            iconSize: 30,
                          ),
                        ],
                      ),

                      SizedBox(height: 46),

                      Row(
                        mainAxisAlignment: .spaceBetween,
                        children: [
                          IncomeExpenceCard(
                            cardbgcolor: kGreen,
                            Title: "Income",
                            amount: incomeTotal,
                            image: "assets/images/income.png",
                          ),
                          IncomeExpenceCard(
                            cardbgcolor: kRed,
                            Title: "Expenses",
                            amount:expenseTotal,
                            image: "assets/images/expense.png",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              //line chart
              Padding(
                padding: EdgeInsetsGeometry.all(kDefalutPadding),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      "spend frequency",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: .w500,
                        color: kBlack,
                      ),
                    ),
                    SizedBox(height: 20),
                    LineChartSample(),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsGeometry.all(kDefalutPadding),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Text(
                      "Recent transactions",
                      style: TextStyle(
                        fontSize: 18,
                        color: kBlack,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 20),
                    Column(
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
                            return ExpenseCard(
                              Title: expense.Title,
                              date: expense.date,
                              amount: expense.amount,
                              category: expense.category,
                              description: expense.Description,
                              time: expense.time,
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
