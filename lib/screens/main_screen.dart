import 'package:expenz/models/expense_model.dart';
import 'package:expenz/screens/add_new_page.dart';
import 'package:expenz/screens/budget_page.dart';
import 'package:expenz/screens/home_page.dart';
import 'package:expenz/screens/profile_page.dart';
import 'package:expenz/screens/transactions_page.dart';
import 'package:expenz/services/expense_services.dart';
import 'package:expenz/utils/colors.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentPageIndex = 0;
  List<ExpenseModel>expenceList=[];
  //functions to fetch expenses
  void fetchAllExpenses()async{
    List<ExpenseModel>loadedExpenses=await ExpenseServices().loadExpenses();
    setState(() {
      expenceList=loadedExpenses;
      print(expenceList.length);
    });
  }
// function to add new expense
void addNewExpense (ExpenseModel newExpense){
  ExpenseServices().saveExpenses(newExpense, context);

  //update the list of expenses
  setState(() {
    expenceList.add(newExpense);
  });

}
  @override
  void initState() {
   setState(() {
     fetchAllExpenses();
   });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      HomePage(),
      TransactionsPage(),
      AddNewPage(addExpense:addNewExpense ,),
      BudgetPage(),
      ProfilePage(),
    ];
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: kWhite,
        selectedItemColor: kMainColor,
        unselectedItemColor: kGrey,
        currentIndex: _currentPageIndex,
        onTap: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },

        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_rounded),
            label: "transaction",
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: kMainColor,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.add, color: kWhite),
            ),
            label: "",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.pie_chart), label: "Budget"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
      body: pages[_currentPageIndex],
    );
  }
}
