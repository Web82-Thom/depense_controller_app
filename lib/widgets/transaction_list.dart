import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import '../models/transaction.dart';

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
            return Column(children: <Widget>[
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
          })
           
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
                      trailing: IconButton(
                        icon: Icon(Icons.delete), 
                        color: Theme.of(context).errorColor,
                        onPressed: () => deleteTx(transactions[index].id),
                        ),
                    ),
                );
              },
              itemCount: transactions.length,
            );
    
  }
}
