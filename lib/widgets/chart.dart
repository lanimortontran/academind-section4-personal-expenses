import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const Chart({Key key, this.recentTransactions}) : super(key: key);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      double totalSum = 0.0;

      // for (var i = 0; i < recentTransactions.length; i++) {
      //   if (recentTransactions[i].date.day == weekDay.day && recentTransactions[i].date.month == weekDay.month && recentTransactions[i].date.year == weekDay.year) {
      //     totalSum += recentTransactions[i].amount;
      //   }
      // }
      for (Transaction tx in recentTransactions) {
        if (tx.date.day == weekDay.day && tx.date.month == weekDay.month && tx.date.year == weekDay.year) {
          totalSum += tx.amount;
        }
      }

      // print(DateFormat.E().format(weekDay));
      // print(totalSum);

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 3),
        'amount': totalSum,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);

    return Card(
      elevation: 6.0,
      margin: EdgeInsets.all(20),
      child: Row(
        children: groupedTransactionValues.map((data) {
          return Text('${data['day']}: ${data['amount']}');
        }).toList(),
      ),
    );
  }
}
