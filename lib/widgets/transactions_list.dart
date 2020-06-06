import 'package:expense_tracker/module/transactions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionsList extends StatefulWidget {
  final List<Transaction> transactions;
  final Function delTx;
  TransactionsList(this.transactions, this.delTx);

  @override
  _TransactionsListState createState() => _TransactionsListState();
}

class _TransactionsListState extends State<TransactionsList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 310,
      child: widget.transactions.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  "No transactions added yet!",
                  style: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    height: 150,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ))
              ],
            )
          : ListView.builder(
              itemCount: widget.transactions.length,
              itemBuilder: (ctx, index) {
                return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    margin: EdgeInsets.all(10),
                    elevation: 8,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(6),
                          child: CircleAvatar(
                            backgroundColor: Theme.of(context).primaryColor,
                            foregroundColor: Colors.white,
                            radius: 30,
                            child: Padding(
                              padding: const EdgeInsets.all(6),
                              child: FittedBox(
                                child: Text(
                                  "\$${widget.transactions[index].amount.toStringAsFixed(2)}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  widget.transactions[index].title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(DateFormat.yMMMMd()
                                    .format(widget.transactions[index].date)),
                              ],
                            ),
                          ),
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.delete,
                              size: 30,
                              color: Theme.of(context).primaryColor,
                            ),
                            onPressed: () => widget.delTx(widget.transactions[index].id)),
                      ],
                    ));
              },
            ),
    );
  }
}
