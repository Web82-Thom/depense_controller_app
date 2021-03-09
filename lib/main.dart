import 'package:flutter/material.dart';

import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dépenses personnel',
      theme: ThemeData(
        //color principal du theme
        primarySwatch: Colors.blue,
        //color button
        accentColor: Colors.amber,
        //fonts
        fontFamily: 'Quicksand',
        //font des autres titres title of transactions
        textTheme: ThemeData.light().textTheme.copyWith(
          headline6: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          )
        ),
        // font appbar
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
            //jouer avec les options HeadLine
            headline6: TextStyle(
              fontFamily: 'OpenSans', 
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      home: MyHomePage(title: 'Gestions des dépenses'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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

    setState((){
      _userTransactions.add(newTx);
    });
  }

  //Creer une méthode pour affiché le form d'un new-transaction
  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child : NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        ); 
    },);
  }
  //CONSTRUCTEUR DE LA PAGE
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title, 
        ),
        //ajout d'un buton +
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add), 
            onPressed: () => _startAddNewTransaction(context),
          )
        ],

      ),
      //mise en column du body
      body: SingleChildScrollView(
              child: Column(
          //style de la column
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            //espace graphique dans un container
            Container(
              width: double.infinity,
              child: Card(
                //envelopper le Text et donner des dimensions avec un widget container dimensionnel pour envelopper le Text et donner des dimensions
                child:
                    Container(color: Colors.blue[200], child: Text('Graphique')),
                // style de la card ombre
                elevation: 5,
              ),
            ),
            TransactionList(_userTransactions),
            //liste des transactions
          ],
        ),
      ),
      //emplecement du button en bas
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      //ajout d'un bouton flottant
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        //si on appuit montre le form title + amount
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}