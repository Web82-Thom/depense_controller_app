import 'package:flutter/material.dart';

import '../models/transaction.dart';
import 'transaction_item.dart';

class TransactionList extends StatelessWidget {
  //recuperer les transactions a partir du getter model/transaction
  final List<Transaction> transactions;
  final Function deleteTx;
  //Instencie la list et function
  TransactionList(this.transactions, this.deleteTx);

  //CONSTRUCTEUR DU CONTAINER DISPLAY TRANSACTION
  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
    ? LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        children: <Widget>[
          Text(
            'Pas de transaction!',
            style: Theme.of(context).textTheme.headline6,
          ),
          //Utiliser généralement en espacement
          SizedBox(
            height: 20,
          ),
          //Mettre l'image dans un container
          Container(
            height: constraints.maxHeight * 
            0.5,
            child: Image.asset(
              'assets/images/waiting.png',
              fit: BoxFit.cover,
            )
          ),
        ],
      );
    },)
    : ListView(
      children: transactions.map((tx) => 
        TransactionItem(
          key: ValueKey(tx.id),
          transaction: tx,
          deleteTx: deleteTx,
        )
      ).toList(),
    );
  }
}
