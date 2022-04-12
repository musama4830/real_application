import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Models/transaction.dart';

class TransactionList extends StatefulWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;
  TransactionList(this.transactions, this.deleteTransaction);

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      child: widget.transactions.isEmpty
          ? Column(
              children: [
                const SizedBox(height: 10),
                const Text('No transactions added yet!'),
                const SizedBox(height: 10),
                Container(
                  child: Image.network('https://picsum.photos/250?image=9'),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: Padding(
                          padding: EdgeInsets.all(6),
                          child: FittedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                  '\$${widget.transactions[index].amount}'),
                            ),
                          )),
                    ),
                    title: Text(
                      widget.transactions[index].title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(DateFormat.yMMMd()
                        .format(widget.transactions[index].date)),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      color: Theme.of(context).errorColor,
                      onPressed: () =>
                          widget.deleteTransaction(widget.transactions[index].id),
                    ),
                  ),
                );
              },
              itemCount: widget.transactions.length,
            ),
    );
  }
}
