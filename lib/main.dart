import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'models/transaction.dart';
import 'widgets/chart.dart';
import 'widgets/new_transaction.dart';
import 'widgets/transaction_list.dart';

void main() {
  // Control device orientation
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(MyApp());
}

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
              titleSmall: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
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

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransaction.where((tx) => tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)))).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      id: DateTime.now().toString(), // Just for purposes of this app, this way of generating an id is fine
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
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

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere((tx) => tx.id == id);
    });
  }

  List<Widget> _buildLandscapeContent(MediaQueryData mediaQuery, PreferredSizeWidget appBar, Widget txListWidget) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Show Chart',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Switch.adaptive(
            activeColor: Theme.of(context).accentColor,
            value: _showChart,
            onChanged: (switchVal) {
              setState(() {
                _showChart = switchVal;
              });
            },
          ),
        ],
      ),
      _showChart
          ? Container(
              // Calculate full height - appBar - status bar, then take up % of available space
              height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.7,
              child: Chart(recentTransactions: _recentTransactions),
            )
          : txListWidget,
    ];
  }

  List<Widget> _buildPortraitContent(MediaQueryData mediaQuery, PreferredSizeWidget appBar, Widget txListWidget) {
    return [
      Container(
        // Calculate full height - appBar - status bar, then take up % of available space
        height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.3,
        child: Chart(recentTransactions: _recentTransactions),
      ),
      txListWidget
    ];
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData _mediaQuery = MediaQuery.of(context);
    final bool _isLandscape = _mediaQuery.orientation == Orientation.landscape;

    Text _appTitle = Text('Personal Expenses');

    final PreferredSizeWidget _appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: _appTitle,
            trailing: Row(
              mainAxisSize: MainAxisSize.min, // By default, Row takes up as much width as possible, which would run the appTitle off-screen
              children: <Widget>[
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => _startAddNewTransaction(context),
                )
              ],
            ),
          )
        : AppBar(
            title: _appTitle,
            actions: <Widget>[
              IconButton(
                onPressed: () => _startAddNewTransaction(context),
                icon: Icon(Icons.add),
              ),
            ],
          );

    final txListWidget = Container(
      // Calculate full height - appBar - status bar, then take up % of available space
      height: (_mediaQuery.size.height - _appBar.preferredSize.height - _mediaQuery.padding.top) * 0.7,
      child: TransactionList(_userTransaction, _deleteTransaction),
    );

    final SafeArea _pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Spread operator (...) and null-aware spread operator (...?) combines 2+ lists and extends the collection's <T> elements as a list
            // https://github.com/dart-lang/language/blob/master/accepted/2.3/unified-collections/feature-specification.md
            // var list = [1, 2, 3];
            // var list2 = [0, ...list]
            if (_isLandscape) ..._buildLandscapeContent(_mediaQuery, _appBar, txListWidget),
            if (!_isLandscape) ..._buildPortraitContent(_mediaQuery, _appBar, txListWidget),
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: _pageBody,
            navigationBar: _appBar,
          )
        : Scaffold(
            appBar: _appBar,
            body: _pageBody,
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    onPressed: () => _startAddNewTransaction(context),
                    child: Icon(Icons.add),
                  ),
          );
  }
}
