import 'package:expenz/utils/colors.dart';
import 'package:expenz/utils/constants.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatefulWidget {
  final String title;
  final double amount;
  final double total;
  final Color prograssColor;
  final bool isExpense;

  const CategoryCard({
    super.key,
    required this.title,
    required this.amount,
    required this.total,
    required this.prograssColor,
    required this.isExpense,
  });

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {

    double prograssWidth=widget.total!=0?MediaQuery.of(context).size.width*(widget.amount/widget.total):0;
    

    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(kDefalutPadding),
      decoration: BoxDecoration(
        borderRadius: .circular(15),
        color: kWhite,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20),
        ],
      ),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: widget.prograssColor.withOpacity(0.1),
                  borderRadius: .circular(100),
                ),
                child: Padding(
                  padding: EdgeInsetsGeometry.symmetric(
                    vertical: 5,
                    horizontal: 20,
                  ),
                  child: Row(
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: .w600,
                          color: kBlack,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "${(widget.amount / widget.total * 100).toStringAsFixed(2)}%",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: .w400,
                          color: kBlack,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                "${widget.amount.toStringAsFixed(2)}\$",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: .w600,
                  color: widget.isExpense ? kRed : kGreen,
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          //linear prograss bar
          Container(
            height: 10,
            width:prograssWidth ,
            decoration: BoxDecoration(
              color: widget.prograssColor,
              borderRadius: .circular(10),
            ),
            ),
        ],
      ),
    );
  }
}
