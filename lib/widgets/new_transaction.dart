import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function onAddHandler;

  final titleController = TextEditingController();
  final amountController = TextEditingController();

  NewTransaction({Key key, this.onAddHandler}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              // onChanged: (value) {
              //   titleInput = value;
              // },
              controller: titleController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              // onChanged: (value) => amountInput = value,
              controller: amountController,
            ),
            FlatButton(
              onPressed: () {
                // print(titleInput);
                // print(amountInput);
                print(titleController.text);
                print(amountController.text);
                onAddHandler(
                  titleController.text,
                  double.parse(amountController.text), // Ideally, add validation around this to make sure it's a valid double
                );
              },
              child: Text('Add Transaction'),
              textColor: Colors.purple,
            )
          ],
        ),
      ),
    );
  }
}
