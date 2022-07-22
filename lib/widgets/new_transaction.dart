import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function onAddHandler;

  NewTransaction({Key key, this.onAddHandler}) : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    try {
      final enteredTitle = _titleController.text;
      final enteredAmount = double.parse(_amountController.text);

      if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
        return;
      }

      widget.onAddHandler(enteredTitle, enteredAmount, _selectedDate);

      Navigator.of(context).pop();
    } catch (e) {
      return;
    }
  }

  void _displayDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
            top: 10.0,
            left: 10.0,
            right: 10.0,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                // onChanged: (value) {
                //   titleInput = value;
                // },
                controller: _titleController,
                onSubmitted: (_) => _submitData(), // Triggered when green check on keyboard is pressed
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                // onChanged: (value) => amountInput = value,
                controller: _amountController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitData(), // Triggered when green check on keyboard is pressed
              ),
              Container(
                height: 70.0,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(_selectedDate == null ? 'No Date Chosen!' : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}'),
                    ),
                    Platform.isIOS
                        ? CupertinoButton(
                            child: Text(
                              'Choose Date',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            onPressed: _displayDatePicker,
                          )
                        : FlatButton(
                            textColor: Theme.of(context).primaryColor,
                            onPressed: _displayDatePicker,
                            child: Text(
                              'Choose Date',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                  ],
                ),
              ),
              FlatButton(
                onPressed: _submitData,
                child: Text('Add Transaction'),
                color: Theme.of(context).primaryColor,
                // textColor: Theme.of(context).textTheme.labelSmall.color,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
