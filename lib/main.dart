import 'package:flutter/material.dart';
import './transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestion de mes dépenses',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Gestion des dépenses'),
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
  //Liste des transactions
  //Ne pas oublier l'import
  final List<Transaction> transactions = [
    //creation de la transaction grace à l'objet transaction()
    Transaction(
      id: 'T1',
      title: 'nouvelle chaussure',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      //mise en column du body
      body: Column(
        //style de la column
        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
          //liste des transactions
          Card(
            color: Colors.red[200],
            child: Text('Liste des transactions(TX)'),
          )
        ],
      ),
    );
  }
}
