import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  //recuperer le transactions
  final List<Transaction> transactions;

  //Instencie la list
  TransactionList(this.transactions);

  //CONSTRUCTEUR DU CONTAINER DISPLAY TRANSACTION
  @override
  Widget build(BuildContext context) {
    return Container(
      //important mettre une hauteur
      height: 300,
      //methode de scroll par ListView et la propriété itemBuilder en fontion annonyme
      child: transactions.isEmpty
          ? Column(children: <Widget>[
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
                height: 200,
                child: Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover,
                )
              ),
            ])
          : ListView.builder(
              itemBuilder: (contexte, index) {
                return Card(
                  child: Row(
                    children: <Widget>[
                      //AMOUNT
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 15,
                        ),
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: Theme.of(context).primaryColor,
                          width: 2,
                        )),
                        child: Text(
                          transactions[index].amount.toStringAsFixed(2) +
                              '€', //pour le $ '\$${tx.amount}'
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            // rappel de la couleur du theme
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      //TITLE AND DATE
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            transactions[index].title,
                            //Le style par rapport au theme predefini dans main.dart
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Text(
                            DateFormat.yMEd('fr').format(transactions[index].date),
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey[400],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
