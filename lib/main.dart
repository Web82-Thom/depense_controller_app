// import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';
import './widgets/chart.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  //mode affichage portrait uniquement
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
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
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''), // English, no country code
        const Locale('fr', ''), // Français, no country code
        // const Locale.fromSubtags(languageCode: 'zh'), // Chinese *See Advanced Locales below*
        // ... other locales the app supports
      ],
      title: 'Dépenses personnel',
      theme: ThemeData(
        //color principal du theme
        primarySwatch: Colors.blue,
        //color button
        accentColor: Colors.amber,
        errorColor: Colors.red,
        //fonts
        fontFamily: 'Quicksand',
        //font des autres titres title of transactions
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
              button: TextStyle(
                color: Colors.white,
              ),
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

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver{
  //LIST DES TRANSACTIONS
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 'T1',
    //   title: 'Nouvelle chaussure',
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 'T2',
    //   title: 'Téléphone',
    //   amount: 150,
    //   date: DateTime.now(),
    // ),
  ];
  //bolean pour l'affichage en responsive orientation
  bool _showChart = false;

  //methode listenner
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }
  //Creer une methode app en background ou forground
  @override 
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);

  }
  //efface les lidtenner des modifications du cycle de vie
  @override
  dispose(){
   WidgetsBinding.instance.removeObserver(this); 
   super.dispose();
  }

  //guetter transactions
  List<Transaction> get _recentTransactions {
    //executer une function sur chaque éléments d'une liste. si c'est true l'élément est conserver dans une list (.where)
    return _userTransactions.where((tx) {
      //verifie seule les transaction des 7 dernier jours
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  //Methode pour ajouter une transaction et pointer sur les values txTitle et txAmount
  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
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
          child: NewTransaction(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  //Creer une méthode pour la construction en affichage Landscape
  List<Widget> _buildLandscapeContent(
    MediaQueryData mediaQuery,
    AppBar appBar,
    Widget txListWidget,
  ) {
    return [Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Voir le graphique',
          style: Theme.of(context).textTheme.headline6,
        ),
        // button true or false
        Switch(
          activeColor: Theme.of(context).accentColor,
          value: _showChart,
          onChanged: (val) {
            setState(() {
              _showChart = val;
            });
          },
        ),
      ],
    ), 
    _showChart
                ? Container(
                    height: (mediaQuery.size.height -
                            appBar.preferredSize.height -
                            mediaQuery.padding.top) *
                        0.7,
                    child: Chart(_recentTransactions),
                  )
                :
                //sinon affichage de la liste des transactions
                txListWidget,];
  }

  //Creer une méthode pour la construction en affichage portrait
  List<Widget> _buildPortraitContent(
    MediaQueryData mediaQuery,
    AppBar appBar,
    Widget txListWidget,
  ) {
    return [Container(
      height: (
        mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top
      ) 
      * 0.3,
      child: Chart(_recentTransactions,),
    ),
    txListWidget];
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  //CONSTRUCTEUR DE LA PAGE
  @override
  Widget build(BuildContext context) {
    //creation var pour le mediaQuery
    final mediaQuery = MediaQuery.of(context);
    //creation var pour l'affichage en paysage
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final appBar = AppBar(
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
    );
    // création d'une variable pour stocker la taille et contenue du container liste de transaction
    final txListWidget = Container(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          0.7,
      child: TransactionList(
        _userTransactions,
        _deleteTransaction,
      ),
    );
    // creation variable pour la page body
    final pageBody = SingleChildScrollView(
      child: Column(
        //style de la column
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          //et condition si c'est en paysage alors
          if (isLandscape) ..._buildLandscapeContent(
            mediaQuery,
            appBar,
            txListWidget,
          ),
          //si on est pas en paysage
          if (!isLandscape)
            ..._buildPortraitContent(
              mediaQuery,
              appBar,
              txListWidget,
            ),
        ],
      ),
    );
    // var du button action
    final actionButton = FloatingActionButton(
      child: Icon(Icons.add),
      //si on appuit montre le form title + amount
      onPressed: () => _startAddNewTransaction(context),
    );
    // Contenu de la page en integrant les variables
    return Scaffold(
      appBar: appBar,
      body: pageBody,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: actionButton,
    );
  }
}
