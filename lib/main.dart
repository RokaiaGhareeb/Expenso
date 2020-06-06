import 'package:expense_tracker/widgets/chart.dart';
import 'package:expense_tracker/widgets/new_transactions.dart';
import 'package:expense_tracker/widgets/transactions_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'module/transactions.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp]
  );
  runApp(MyApp());
} 

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expenso',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        fontFamily: 'Quicksand',
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(
      String newTitle, String newAmount, DateTime selectedDate) {
    final newtx = Transaction(
        title: newTitle,
        amount: double.parse(newAmount),
        date: selectedDate,
        id: DateTime.now().toString());
    setState(() {
      _userTransactions.add(newtx);
    });
  }

  void _startNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: ctx,
        builder: (_) {
          return NewTransactions(_addNewTransaction);
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('Expenso'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startNewTransaction(context),
        ),
      ],
    );
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: appBar,
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
                height: (MediaQuery.of(context).size.height -
                    appBar.preferredSize.height -
                    MediaQuery.of(context).padding.top ) * 0.35,
                child: Chart(_recentTransactions)),
            Container(
               height: (MediaQuery.of(context).size.height -
                    appBar.preferredSize.height -
                    MediaQuery.of(context).padding.top ) * 0.5,
                child: TransactionsList(_userTransactions, _deleteTransaction)),
          ]),
      floatingActionButton: FloatingActionButton(
        elevation: 30,
        child: Icon(Icons.add),
        onPressed: () => _startNewTransaction(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
