import 'package:flutter/material.dart';

import './new_transaction.dart';
import './transaction_list.dart';
import '../models/transaction.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 'T1',
      title: 'Nouvelle chaussure',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 'T2',
      title: 'Téléphone',
      amount: 150,
      date: DateTime.now(),
    ),
  ];

  //Methode pour ajouter une transaction et pointer sur les values txTitle et txAmount
  void _addNewTransaction(String txTitle, double txAmount) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: DateTime.now(),
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        //Appel la listes des nouvelles transaction par sa function et le pointeur _addNewTransaction pour l'ajout d'une nouvelle transaction
        NewTransaction(_addNewTransaction),
        //Appel la listes des transaction par sa function
        TransactionList(_userTransactions),
      ],
    );
  }
}
