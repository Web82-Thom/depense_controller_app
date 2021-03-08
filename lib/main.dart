import 'package:flutter/material.dart';

import './widgets/user_transactions.dart';
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
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
            UserTransactions(),
            //liste des transactions
          ],
        ),
      ),
    );
  }
}
