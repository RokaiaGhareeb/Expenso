import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double percentageOfSpendedAmount;
  ChartBar(this.label, this.spendingAmount, this.percentageOfSpendedAmount);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constrains) {
        return Column(
          children: <Widget>[
            Container(
              height: constrains.maxHeight * 0.15,
              child: FittedBox(
                child: Text(
                  '\$${spendingAmount.toStringAsFixed(0)}',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            SizedBox(
              height: constrains.maxHeight * 0.05,
            ),
            Container(
              width: 20,
              height: constrains.maxHeight * 0.6,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: percentageOfSpendedAmount,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: constrains.maxHeight * 0.05,
            ),
            Container(
              height: constrains.maxHeight * 0.15,
              child: Text(
                label,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        );
      },
    );
  }
}
