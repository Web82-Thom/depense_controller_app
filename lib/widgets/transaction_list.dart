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
                  elevation: 6,
                  margin: EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 10,
                  ),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        child : Padding(
                          padding: EdgeInsets.all(6),
                          child: FittedBox(
                            child: Text(
                              transactions[index].amount.toStringAsFixed(2) +'€',
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        transactions[index].title,
                        //Le style par rapport au theme predefini dans main.dart
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      subtitle: Text(
                        DateFormat.yMEd('fr').format(transactions[index].date),
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[400],
                        ),
                      ),
                      // trailing: IconButton(
                      //   icon: Icon(Icons.delete), 
                      //   color: Theme.of(context).errorColor,
                      //   onPressed: () {},
                      //   ),
                    ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
