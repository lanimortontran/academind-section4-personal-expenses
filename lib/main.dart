import 'package:flutter/material.dart';

import 'models/transaction.dart';
import 'widgets/chart.dart';
import 'widgets/new_transaction.dart';
import 'widgets/transaction_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
              titleMedium: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
              // labelSmall: TextStyle(color: Colors.white),
            ),
        buttonTheme: ThemeData.light().buttonTheme.copyWith(
              textTheme: ButtonTextTheme.primary,
            ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    Transaction(
      id: 't3',
      title: 'New Hat',
      amount: 12,
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
    Transaction(
      id: 't4',
      title: 'New Sunglasses',
      amount: 15.0,
      date: DateTime.now().subtract(Duration(days: 2)),
    ),
    Transaction(
      id: 't5',
      title: 'Gym Fees',
      amount: 75.43,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: 't6',
      title: 'Festival Tickets',
      amount: 107.09,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
    Transaction(
      id: 't7',
      title: 'Pet Food',
      amount: 33.89,
      date: DateTime.now().subtract(Duration(days: 5)),
    ),
    Transaction(
      id: 't8',
      title: 'Camping Gear',
      amount: 254.39,
      date: DateTime.now().subtract(Duration(days: 6)),
    ),
    Transaction(
      id: 't9',
      title: 'Snack',
      amount: 1.07,
      date: DateTime.now().subtract(Duration(days: 7)), // Should not show up in recent transactions
    ),
    Transaction(
      id: 't10',
      title: 'Beer',
      amount: 5.93,
      date: DateTime.now().subtract(Duration(days: 8)), // Should not show up in recent transactions
    ),
  ];

  List<Transaction> get _recentTransactions {
    return _userTransaction.where((tx) => tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)))).toList();
  }

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

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(onAddHandler: _addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Expenses'),
        actions: <Widget>[
          IconButton(
            onPressed: () => _startAddNewTransaction(context),
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Chart(
                recentTransactions: _recentTransactions,
              ),
            ),
            TransactionList(_userTransaction),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(onPressed: () => _startAddNewTransaction(context), child: Icon(Icons.add)),
    );
  }
}
