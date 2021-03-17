import 'dart:math';

import 'package:flutter/material.dart';
import '../models/transaction.dart';

import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.deleteTx,
  }) : super(key: key);

  final Transaction transaction;
  final Function deleteTx;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
Color _bgColor;
@override
//exemple circle amount differente couleurs
void initState() {
    const avaibleColors =[
      Colors.green,
      Colors.yellow,
      Colors.red,
      Colors.black,
    ];
    _bgColor= avaibleColors[Random().nextInt(4)];
    super.initState();
}

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: _bgColor ,
            radius: 30,
            child : Padding(
              padding: EdgeInsets.all(6),
              child: FittedBox(
                child: Text(
                  widget.transaction.amount.toStringAsFixed(2) +'€',
                ),
              ),
            ),
          ),
          title: Text(
            widget.transaction.title,
            //Le style par rapport au theme predefini dans main.dart
            style: Theme.of(context).textTheme.headline6,
          ),
          subtitle: Text(
            DateFormat.yMEd('fr').format(widget.transaction.date),
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[400],
            ),
          ),
          trailing: MediaQuery.of(context).size.width > 460 
          ? TextButton.icon(
            icon:  Icon(
              Icons.delete, 
              color: Theme.of(context).errorColor,
            ),
            label: Text(
              'Supprimer', 
              style: TextStyle(
              color: Theme.of(context).errorColor, 
              ),
            ),
            onPressed: () => widget.deleteTx(widget.transaction.id),
          )
          :IconButton(
            icon: Icon(Icons.delete), 
            color: Theme.of(context).errorColor,
            onPressed: () => widget.deleteTx(widget.transaction.id),
            ),
        ),
    );
  }
}