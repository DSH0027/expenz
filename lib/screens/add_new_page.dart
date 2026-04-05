import 'package:expenz/models/expense_model.dart';
import 'package:expenz/models/income_model.dart';
import 'package:expenz/services/expense_services.dart';
import 'package:expenz/services/income_services.dart';
import 'package:expenz/utils/colors.dart';
import 'package:expenz/utils/constants.dart';
import 'package:expenz/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddNewPage extends StatefulWidget {
  final Function(ExpenseModel) addExpense;
  final Function(IncomeModel) addIncome;
  const AddNewPage({super.key, required this.addExpense, required this.addIncome});

  @override
  State<AddNewPage> createState() => _AddNewPageState();
}

class _AddNewPageState extends State<AddNewPage> {
  int _selectedmethode = 0;
  expensecategory _expense = expensecategory.Health;
  incomeCategory _icome = incomeCategory.salary;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  DateTime _selectedTime = DateTime.now();
  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _selectedmethode == 0 ? kRed : kGreen,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: kDefalutPadding),
            child: Stack(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(kDefalutPadding),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.06,
                      decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Row(
                        mainAxisAlignment: .spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedmethode = 0;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: _selectedmethode == 0
                                    ? kMainColor
                                    : null,
                                borderRadius: BorderRadius.circular(32),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 60,
                                  vertical: 10,
                                ),
                                child: Text(
                                  "Expense",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: .w500,
                                    color: _selectedmethode == 0
                                        ? kWhite
                                        : kBlack,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedmethode = 1;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: _selectedmethode == 1
                                    ? kMainColor
                                    : null,
                                borderRadius: BorderRadius.circular(32),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 60,
                                  vertical: 10,
                                ),
                                child: Text(
                                  "Income",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: .w500,
                                    color: _selectedmethode == 1
                                        ? kWhite
                                        : kBlack,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.1,
                    left: MediaQuery.of(context).size.width * 0.05,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "How much ?",
                        style: TextStyle(
                          color: kGrey,
                          fontSize: 18,
                          fontWeight: .w400,
                        ),
                      ),

                      TextField(
                        style: TextStyle(
                          fontSize: 60,
                          color: kWhite,
                          fontWeight: .w400,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "0",
                          hintStyle: TextStyle(
                            color: kWhite,
                            fontSize: 60,
                            fontWeight: .bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // creating user input form
                Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.27,
                  ),
                  decoration: BoxDecoration(
                    color: kWhite,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      child: Column(
                        children: [
                          //category selected dropdown
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(38),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: kDefalutPadding,
                              ),
                            ),
                            items: _selectedmethode == 0
                                ? expensecategory.values.map((Category) {
                                    return DropdownMenuItem(
                                      value: Category,
                                      child: Text(Category.name),
                                    );
                                  }).toList()
                                : incomeCategory.values.map((Category) {
                                    return DropdownMenuItem(
                                      value: Category,
                                      child: Text(Category.name),
                                    );
                                  }).toList(),

                            value: _selectedmethode == 0 ? _expense : _icome,
                            onChanged: (value) {
                              setState(() {
                                _selectedmethode == 0
                                    ? _expense = value as expensecategory
                                    : _icome = value as incomeCategory;
                              });
                            },
                          ),
                          SizedBox(height: 13),
                          TextFormField(
                            controller: _titleController,
                            decoration: InputDecoration(
                              hintText: "Title",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(38),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: kDefalutPadding,
                              ),
                            ),
                          ),
                          SizedBox(height: 13),
                          TextFormField(
                            controller: _descriptionController,
                            decoration: InputDecoration(
                              hintText: "Description",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(38),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: kDefalutPadding,
                              ),
                            ),
                          ),
                          SizedBox(height: 13),
                          TextFormField(
                            controller: _amountController,
                            keyboardType: TextInputType.numberWithOptions(),
                            decoration: InputDecoration(
                              hintText: "Amount",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(38),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: kDefalutPadding,
                              ),
                            ),
                          ),
                          SizedBox(height: 13),
                          //date picker
                          Row(
                            mainAxisAlignment: .spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showDatePicker(
                                    context: context,
                                    firstDate: DateTime(2020),
                                    lastDate: DateTime(2030),
                                    initialDate: DateTime.now(),
                                  ).then((value) {
                                    if (value != null) {
                                      setState(() {
                                        _selectedDate = value;
                                      });
                                    }
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    color: kMainColor,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 10,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_month,
                                          color: kWhite,
                                          size: 32,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          "Select date",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: kWhite,
                                            fontWeight: .w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                DateFormat.yMMMd().format(_selectedDate),
                                style: TextStyle(
                                  color: kGrey,
                                  fontSize: 16,
                                  fontWeight: .w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 13),
                          //Time picker
                          Row(
                            mainAxisAlignment: .spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then((value) {
                                    if (value != null) {
                                      setState(() {
                                        _selectedTime = DateTime(
                                          _selectedDate.year,
                                          _selectedDate.month,
                                          _selectedDate.day,
                                          value.hour,
                                          value.minute,
                                        );
                                      });
                                    }
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    color: kYellow,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 10,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.watch_later,
                                          color: kWhite,
                                          size: 32,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          "Select Time",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: kWhite,
                                            fontWeight: .w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                DateFormat.jm().format(_selectedTime),
                                style: TextStyle(
                                  color: kGrey,
                                  fontSize: 16,
                                  fontWeight: .w500,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 13),
                          Divider(thickness: 2),
                          SizedBox(height: 13),
                          //submit button
                          GestureDetector(
                            onTap: () async {
                              if (_selectedmethode == 0) {
                                //save the expenses data into shared prefs
                                List<ExpenseModel> loadedExpenses =
                                    await ExpenseServices().loadExpenses();

                                //create the expense to store
                                ExpenseModel expense = ExpenseModel(
                                  id: loadedExpenses.length + 1,
                                  Title: _titleController.text,
                                  category: _expense,
                                  date: _selectedDate,
                                  time: _selectedTime,
                                  Description: _descriptionController.text,
                                  amount: _amountController.text.isEmpty
                                      ? 0
                                      : double.parse(_amountController.text),
                                );
                                //clear the fields
                                _titleController.clear();
                                _amountController.clear();
                                _descriptionController.clear();

                                //add expense
                                widget.addExpense(expense);
                              } else {
                                //load income
                                List<IncomeModel> loadedIncome =
                                    await IncomeServices().loadIncome();
                                //create the new income
                                IncomeModel income = IncomeModel(
                                  id: loadedIncome.length + 1,
                                  Title: _titleController.text,
                                  category: _icome,
                                  date: _selectedDate,
                                  time: _selectedTime,
                                  Description: _descriptionController.text,
                                  amount: _amountController.text.isEmpty
                                      ? 0
                                      : double.parse(_amountController.text),
                                );
                                //add Income
                                widget.addIncome(income);
                                 //clear the fields
                                _titleController.clear();
                                _amountController.clear();
                                _descriptionController.clear();

                              }
                            },

                            child: CustomButton(
                              title: "Add",
                              color: _selectedmethode == 0 ? kRed : kGreen,
                            ),
                          ),
                        ],
                      ),
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
