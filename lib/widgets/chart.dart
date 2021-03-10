import 'package:flutter/material.dart';

import './chart_bar.dart';
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

      // Intl.withLocale('fr', () => print('myMessage()'));
      //Intl.defaultLocale = 'pt_BR';
      print(DateFormat.E().format(weekDay));
      print(totalSum);

      // pour gerer les dates utiliser "import intl"
      return {
        'day': DateFormat.EEEE('fr').format(weekDay).substring(0, 1),
         'amount': totalSum,
      };
    });

  }

  double get totalSpending {
    return groupedTransactionValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    //Envelopper ce graph dans une CARD
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactionValues.map((data) {
            
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                data['day'], 
                data['amount'],
                //condition si pas la somme est a 0 alors affiche 0 sinon fait le ratio
                totalSpending == 0.0 
                ? 0.0 : (data['amount']as double) / totalSpending,
              ),
            );
          }).toList(),

        ),
      ),
      
      
    );
  }
}