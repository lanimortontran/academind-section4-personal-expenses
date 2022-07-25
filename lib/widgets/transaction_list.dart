import 'package:flutter/material.dart';

import '../models/transaction.dart';
import 'transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function deleteTx;

  TransactionList(this._transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return _transactions.isEmpty
        ? LayoutBuilder(builder: (context, constraints) {
            return Column(
              children: <Widget>[
                Text(
                  'No transactions added yet!',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (context, index) {
              // return Card(
              //   child: Row(
              //     children: [
              //       Container(
              //         margin: EdgeInsets.symmetric(
              //           vertical: 10.0,
              //           horizontal: 15.0,
              //         ),
              //         decoration: BoxDecoration(
              //           border: Border.all(
              //             color: Theme.of(context).primaryColor,
              //             width: 2.0,
              //           ),
              //         ),
              //         padding: EdgeInsets.all(10.0),
              //         child: Text(
              //           '\$${_transactions[index].amount.toStringAsFixed(2)}',
              //           style: TextStyle(
              //             fontWeight: FontWeight.bold,
              //             fontSize: 20.0,
              //             color: Colors.purple,
              //           ),
              //         ),
              //       ),
              //       Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(
              //             _transactions[index].title,
              //             style: Theme.of(context).textTheme.titleMedium, // Style the transaction titles using the app theme's title config
              //           ),
              //           Text(
              //             DateFormat.yMd().format(_transactions[index].date),
              //             style: TextStyle(color: Colors.grey),
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // );
              return TransactionItem(transaction: _transactions[index], deleteTx: deleteTx);
            },
            itemCount: _transactions.length,
          );
  }
}
