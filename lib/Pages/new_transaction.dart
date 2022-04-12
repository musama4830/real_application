import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './my_app.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime selectedDate;

  void submitData() {
    if (amountController.text.isEmpty) {
      return;
    }
    final titleText = titleController.text;
    final amountText = double.parse(amountController.text);

    if (titleText.isEmpty || amountText <= 0 || selectedDate == null) {
      return;
    }

    widget.addTx(
      titleText,
      amountText,
      selectedDate,
    );

    Navigator.of(context).pop();
  }

  void presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickDate) {
      if (pickDate == null) {
        return;
      }
      setState(() {
        selectedDate = pickDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Card(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextField(
                      decoration: const InputDecoration(labelText: 'Title'),
                      controller: titleController,
                      onSubmitted: (_) => submitData,
                    ),
                    TextField(
                      decoration: const InputDecoration(labelText: 'Amount'),
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      onSubmitted: (_) => submitData,
                    ),
                    const SizedBox(height: 10),
                    Container(
                      height: 70,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              selectedDate == null
                                  ? 'No Date Chosen!'
                                  : 'Picked Date: ${DateFormat.yMd().format(selectedDate)}',
                            ),
                          ),
                          FlatButton(
                              child: Text(
                                'Choose Date',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              color: Theme.of(context).primaryColor,
                              onPressed: presentDatePicker)
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    RaisedButton(
                      child: const Text('Add Transaction'),
                      color: Theme.of(context).primaryColor,
                      onPressed: submitData,
                    ),
                  ],
                ),
              ),
              elevation: 5,
            ),
          ),
        ),
      ),
    );
  }
}
