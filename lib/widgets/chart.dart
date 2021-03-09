import 'package:flutter/material.dart';

import '../models/transaction.dart';

import 'package:intl/intl.dart';
// import '../widgets/transaction_list.dart';

//Ce widget produira simplement des données visuelles
class Chart extends StatelessWidget {
  //var pour les recentes transactions
  final List<Transaction> recentTransaction;

  Chart(this.recentTransaction);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      //variable de la date et operation avec subtract
      final weekDay = DateTime.now().subtract(Duration(days: index));
      //Trouvez les transactions qui ce sont produite ce jours là
      double totalSum = 0.0;
      //i est un index plus petit que la longueur des transaction recent(7jours)
      //access list items with [i] => i is dynamic!
      for (var i = 0; i < recentTransaction.length; i ++) {
        //Conditions verification de la date D/M/Y/H
        if (recentTransaction[i].date.day == weekDay.day &&
            recentTransaction[i].date.month == weekDay.month &&
            recentTransaction[i].date.year ==weekDay.year){
              totalSum += recentTransaction[i].amount;
            }
      }

      print(DateFormat.E().format(weekDay));
      print(totalSum);

      // pour gerer les dates utiliser "import intl"
      return {
        'day': DateFormat.E().format(weekDay),
         'amount': totalSum,
      };
    });

  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    //Envelopper ce graph dans une CARD
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      // child: ,
      
    );
  }
}