import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransactions extends StatefulWidget {
  final Function addTx;

  NewTransactions(this.addTx);

  @override
  _NewTransactionsState createState() => _NewTransactionsState();
}

class _NewTransactionsState extends State<NewTransactions> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime selectedDate;

  void _showDatePicker() {
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
        selectedDate = pickedDate;
      });
    });
  }

  void _sumbitData() {
    final String title = titleController.text;
    final double amount = double.parse(amountController.text);
    if (title.isEmpty || amount <= 0 || selectedDate == null) {
      return;
    }
    print(titleController.text);
    print(amountController.text);
    widget.addTx(titleController.text, amountController.text, selectedDate);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Card(
        elevation: 20,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                  controller: titleController,
                  onEditingComplete: _sumbitData,
                  decoration: InputDecoration(
                    labelText: "title",
                    fillColor: Theme.of(context).accentColor,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                controller: amountController,
                onEditingComplete: _sumbitData,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  labelText: "amount",
                  fillColor: Theme.of(context).accentColor,
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                readOnly: true,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.date_range,
                      size: 30,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: _showDatePicker,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  hintText: selectedDate == null
                      ? "Choose date"
                      : DateFormat.yMMMMd().format(selectedDate),
                  fillColor: Theme.of(context).accentColor,
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: FlatButton(
                child: Text(
                  "Add",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: _sumbitData,
              ),
            )
          ],
        ),
      ),
    );
  }
}
