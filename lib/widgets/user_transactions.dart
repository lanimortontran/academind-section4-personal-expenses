import 'package:flutter/material.dart';

import '../models/transaction.dart';
import 'new_transaction.dart';
import 'transaction_list.dart';

class UserTransactions extends StatefulWidget {
  @override
  State<UserTransactions> createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _userTransaction = [
    Transaction(
      id: 't1',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Weekly Groceries',
      amount: 16.53,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't3',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't4',
      title: 'Weekly Groceries',
      amount: 16.53,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't5',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't6',
      title: 'Weekly Groceries',
      amount: 16.53,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't7',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't8',
      title: 'Weekly Groceries',
      amount: 16.53,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't9',
      title: 'New Shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't10',
      title: 'Weekly Groceries',
      amount: 16.53,
      date: DateTime.now(),
    ),
  ];

  void _addNewTransaction(String txTitle, double txAmount) {
    final newTx = Transaction(
      id: DateTime.now().toString(), // Just for purposes of this app, this way of generating an id is fine
      title: txTitle,
      amount: txAmount,
      date: DateTime.now(),
    );

    setState(() {
      // This is a final variable, so the address of the object stored cannot be changed.
      // However, the list that the object holds can be manipulated because it will not generate a new pointer.
      // It is simply modifying the data that the object stores.
      _userTransaction.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(
          onAddHandler: _addNewTransaction,
        ),
        TransactionList(_userTransaction),
      ],
    );
  }
}
