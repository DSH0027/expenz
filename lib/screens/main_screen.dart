import 'package:expenz/models/expense_model.dart';
import 'package:expenz/models/income_model.dart';
import 'package:expenz/screens/add_new_page.dart';
import 'package:expenz/screens/budget_page.dart';
import 'package:expenz/screens/home_page.dart';
import 'package:expenz/screens/profile_page.dart';
import 'package:expenz/screens/transactions_page.dart';
import 'package:expenz/services/expense_services.dart';
import 'package:expenz/services/income_services.dart';
import 'package:expenz/utils/colors.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentPageIndex = 0;
  List<ExpenseModel> expenceList = [];
  List<IncomeModel> incomeList = [];
  //functions to fetch expenses
  void fetchAllExpenses() async {
    List<ExpenseModel> loadedExpenses = await ExpenseServices().loadExpenses();
    setState(() {
      expenceList = loadedExpenses;
    });
  }

  //functions to fetch incomes
  void fetchAllIncomes() async {
    List<IncomeModel> loadedIncome = await IncomeServices().loadIncome();
    setState(() {
      incomeList = loadedIncome;
    });
  }

  // function to add new expense
  void addNewExpense(ExpenseModel newExpense) {
    ExpenseServices().saveExpenses(newExpense, context);

    //update the list of expenses
    setState(() {
      expenceList.add(newExpense);
    });
  }

  //function to add a new income
  void addNewIncome(IncomeModel newIncome) {
    IncomeServices().saveIncome(newIncome, context);

    //update the list of income
    setState(() {
      incomeList.add(newIncome);
    });
  }

  @override
  void initState() {
    setState(() {
      fetchAllExpenses();
      fetchAllIncomes();
    });
    super.initState();
  }

  //function to remove a expense
  void removeExpense(ExpenseModel expense) {
    ExpenseServices().deleteExpenses(expense.id, context);
    setState(() {
      expenceList.remove(expense);
    });
  }

  //functin to delete income
  void removeIncome(IncomeModel income) {
    IncomeServices().deleteIncome(income.id, context);
    setState(() {
      incomeList.remove(income);
    });
  }

  //category expenses total
  Map<expensecategory,double>calculateExpenseCategories(){
    Map<expensecategory,double>categoryTotals={
      expensecategory.Food:0,
      expensecategory.Health:0,
      expensecategory.Shopping:0,
      expensecategory.Subscriptions:0,
      expensecategory.Transport:0,
    };

    for (ExpenseModel expense in expenceList){
      categoryTotals[expense.category]=categoryTotals[expense.category]!+expense.amount;
    }
    return categoryTotals;
  }
  
  //category income total
  Map<incomeCategory,double>calculateIncomeCategories(){
    Map<incomeCategory,double>categoryTotals={
      incomeCategory.freelance:0,
      incomeCategory.passive:0,
      incomeCategory.salary:0,
      incomeCategory.sales:0,
      
    };

    for (IncomeModel income in incomeList){
      categoryTotals[income.category]=categoryTotals[income.category]!+income.amount;
    }
    return categoryTotals;
  }
  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      
      HomePage(
        expenceList: expenceList,
        incomeList: incomeList,
      ),
      TransactionsPage(
        expenceList: expenceList,
        onDismisedExpense: removeExpense,
        incomeList: incomeList,
        onDismissedIncome: removeIncome,
      ),

      AddNewPage(addExpense: addNewExpense, addIncome: addNewIncome),
      BudgetPage(expenseTotal: calculateExpenseCategories(),
      incomeTotal: calculateIncomeCategories(),),
      
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
