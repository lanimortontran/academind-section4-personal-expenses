import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double spendingPercentOfTotal;

  const ChartBar({
    Key key,
    this.label,
    this.spendingAmount,
    this.spendingPercentOfTotal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Size the height of each bar based on the height of the chart row (parent)
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        children: <Widget>[
          Container(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(
              // Shrink child to fit inside. Will prevent line breaks. Ex: $9999.99
              child: Text('\$${spendingAmount.toStringAsFixed(2)}'),
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
            height: constraints.maxHeight * 0.6,
            width: 10,
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    color: Color.fromRGBO(220, 220, 220, 1), // rgb: 0-255 o: 0-1
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: spendingPercentOfTotal,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(
              child: Text(label),
            ),
          ),
        ],
      );
    });
  }
}
