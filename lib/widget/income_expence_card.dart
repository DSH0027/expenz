import 'package:expenz/utils/colors.dart';
import 'package:expenz/utils/constants.dart';
import 'package:flutter/material.dart';

class IncomeExpenceCard extends StatefulWidget {
  final String Title;
  final double amount;
  final String image;
  final Color cardbgcolor;
  const IncomeExpenceCard({
    super.key,
    required this.cardbgcolor,
    required this.Title,
    required this.amount,
    required this.image,
  });

  @override
  State<IncomeExpenceCard> createState() => _IncomeExpenceCardState();
}

class _IncomeExpenceCardState extends State<IncomeExpenceCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      height: MediaQuery.of(context).size.height*0.1,
      decoration: BoxDecoration(
        color: widget.cardbgcolor,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Padding(
        padding: const EdgeInsets.all(kDefalutPadding),
        child: Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width*0.15,
              height: MediaQuery.of(context).size.height*0.15,
              decoration: BoxDecoration(
                color: kWhite,
                borderRadius: BorderRadius.circular(28)
              ),
              child: Image.asset(widget.image)),
              SizedBox(
                width: 10,
              ),
            Column(
              mainAxisAlignment: .center,
              children: [
                Text(widget.Title,style: TextStyle(
                  fontSize: 14,
                  color: kWhite,
                  fontWeight: .w500
                ),), 
                Text("\$ ${widget.amount.toStringAsFixed(0)}",style: TextStyle(
                  color: kWhite,
                  fontSize: 22,
                  fontWeight: .w400
                ),),
              ],
            )
          ],
        ),
      ),
    );
  }
}
