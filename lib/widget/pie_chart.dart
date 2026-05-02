import 'package:expenz/models/expense_model.dart';
import 'package:expenz/models/income_model.dart';
import 'package:expenz/utils/colors.dart';
import 'package:expenz/utils/constants.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Chart extends StatefulWidget {
  final Map<expensecategory, double> expeneseCategoryTotal;
  final Map<incomeCategory, double> incomeCategoryTotal;
  final bool isExpense;

  const Chart({
    super.key,
    required this.expeneseCategoryTotal,
    required this.incomeCategoryTotal,
    required this.isExpense,
  });

  @override
  State<Chart> createState() => _PieChartState();
}

class _PieChartState extends State<Chart> {
  //sections data
  List<PieChartSectionData> getSections() {
    if (widget.isExpense) {
      return [
        PieChartSectionData(
          color: expenseCategoryColor[expensecategory.Food],
          value: widget.expeneseCategoryTotal[expensecategory.Food] ?? 0,
          showTitle: false,
          radius: 60,
        ),
        PieChartSectionData(
          color: expenseCategoryColor[expensecategory.Health],
          value: widget.expeneseCategoryTotal[expensecategory.Health] ?? 0,
          showTitle: false,
          radius: 60,
        ),
        PieChartSectionData(
          color: expenseCategoryColor[expensecategory.Shopping],
          value: widget.expeneseCategoryTotal[expensecategory.Shopping] ?? 0,
          showTitle: false,
          radius: 60,
        ),
        PieChartSectionData(
          color: expenseCategoryColor[expensecategory.Subscriptions],
          value:
              widget.expeneseCategoryTotal[expensecategory.Subscriptions] ?? 0,
          showTitle: false,
          radius: 60,
        ),
        PieChartSectionData(
          color: expenseCategoryColor[expensecategory.Transport],
          value: widget.expeneseCategoryTotal[expensecategory.Transport] ?? 0,
          showTitle: false,
          radius: 60,
        ),
      ];
    } else {
      return [
        PieChartSectionData(
          color: incomeCategoryColor[incomeCategory.freelance],
          value: widget.incomeCategoryTotal[incomeCategory.freelance] ?? 0,
          showTitle: false,
          radius: 60,
        ),
        PieChartSectionData(
          color: incomeCategoryColor[incomeCategory.passive],
          value: widget.incomeCategoryTotal[incomeCategory.passive] ?? 0,
          showTitle: false,
          radius: 60,
        ),
        PieChartSectionData(
          color: incomeCategoryColor[incomeCategory.salary],
          value: widget.incomeCategoryTotal[incomeCategory.salary] ?? 0,
          showTitle: false,
          radius: 60,
        ),
        PieChartSectionData(
          color: incomeCategoryColor[incomeCategory.sales],
          value: widget.incomeCategoryTotal[incomeCategory.sales] ?? 0,
          showTitle: false,
          radius: 60,
        ),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final PieChartData pieChartData = PieChartData(
      sectionsSpace: 0,
      centerSpaceRadius: 70,
      startDegreeOffset: -90,
      sections: getSections(),
      borderData: FlBorderData(show: false),
    );
    return Container(
      height: 250,
      padding: EdgeInsets.all(kDefalutPadding),
      decoration: BoxDecoration(color: kWhite, borderRadius: .circular(16)),
      child: Stack(
        alignment: AlignmentGeometry.center,
        children: [
          PieChart(pieChartData),
          Column(
            mainAxisAlignment: .center,
            children: [
              Text(
                "70%",
                style: TextStyle(color: kBlack, fontWeight: .bold),
              ),
              SizedBox(height: 8),
              Text("of 100%", style: TextStyle(color: kBlack)),
            ],
          ),
        ],
      ),
    );
  }
}
