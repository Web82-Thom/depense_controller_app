import 'package:flutter/material.dart';

import '../models/transaction.dart';
import 'transaction_item.dart';

class TransactionList extends StatelessWidget {
  //recuperer le transactions
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
    : ListView.builder(
        itemBuilder: (contexte, index) {
          return TransactionItem(transaction: transactions[index], deleteTx: deleteTx,);
        },
        itemCount: transactions.length,
    );
  }
}
