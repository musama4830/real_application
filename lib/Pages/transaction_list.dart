import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
    return widget.transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, Constraints) {
              return Column(
                children: [
                  Text('No transactions added yet!'),
                  SizedBox(height: 10),
                  Container(
                    height: Constraints.maxHeight * 0.6,
                    child: Image.network('https://picsum.photos/250?image=9'),
                  ),
                ],
              );
            },
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
                            child:
                                Text('\$${widget.transactions[index].amount}'),
                          ),
                        )),
                  ),
                  title: Text(
                    widget.transactions[index].title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(DateFormat.yMMMd()
                      .format(widget.transactions[index].date)),
                  trailing: MediaQuery.of(context).size.width >=
                          (MediaQuery.of(context).size.height - 100)
                      ? FlatButton.icon(
                          icon: Icon(Icons.delete),
                          label: Text('Delete'),
                          textColor: Theme.of(context).errorColor,
                          onPressed: () => widget
                              .deleteTransaction(widget.transactions[index].id),
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () => widget
                              .deleteTransaction(widget.transactions[index].id),
                        ),
                ),
              );
            },
            itemCount: widget.transactions.length,
          );
  }
}
