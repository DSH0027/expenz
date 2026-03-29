import 'package:expenz/utils/colors.dart';
import 'package:expenz/utils/constants.dart';
import 'package:flutter/material.dart';

class AddNewPage extends StatefulWidget {
  const AddNewPage({super.key});

  @override
  State<AddNewPage> createState() => _AddNewPageState();
}

class _AddNewPageState extends State<AddNewPage> {
  int _selectedmethode=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _selectedmethode==0?kRed:kGreen,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefalutPadding),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: kDefalutPadding),
              child: Stack(
                children: [
                  Center(
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
                                _selectedmethode=0;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: _selectedmethode==0?kMainColor:null,
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
                                    color: _selectedmethode==0?kWhite:kBlack,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedmethode=1;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: _selectedmethode==1?kMainColor:null,
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
                                    color: _selectedmethode==1?kWhite:kBlack,
                                  ),
                                ),
                              ),
                            ),
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
      ),
    );
  }
}
