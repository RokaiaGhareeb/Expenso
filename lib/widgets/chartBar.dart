import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double percentageOfSpendedAmount;
  ChartBar(this.label, this.spendingAmount, this.percentageOfSpendedAmount);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 20,
          child: FittedBox(
                    child: Text(
              '\$${spendingAmount.toStringAsFixed(0)}',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
        SizedBox(height: 4),
        Container(
          width: 20,
          height: 80,
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
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }
}
