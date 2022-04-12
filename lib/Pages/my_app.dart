import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '/Pages/transaction_list.dart';
import '/Pages/new_transaction.dart';
import '../Models/transaction.dart';
import 'chart.dart';

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Transaction> transactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'My Shirts',
    //   amount: 60.75,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'My Shoes',
    //   amount: 75.55,
    //   date: DateTime.now(),
    // ),
  ];

  List<Transaction> get _recentTransactions {
    return transactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(Duration(days: 7)),
      );
    }).toList();
  }

  void addTransaction(String title, double amount, DateTime chosenDate) {
    final addtx = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: chosenDate,
    );

    setState(() {
      transactions.add(addtx);
    });
  }

  void deleteTransaction(String id) {
    setState(() {
      transactions.removeWhere((tx) => tx.id == id);
    });
  }

  void startAddNewTransitions(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(addTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Real App'),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => startAddNewTransitions(context),
            ),
          ],
        ),
        body: Column(
          children: [
            Chart(_recentTransactions),
            TransactionList(transactions, deleteTransaction),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => startAddNewTransitions(context),
        ),
      ),
    );
  }
}
