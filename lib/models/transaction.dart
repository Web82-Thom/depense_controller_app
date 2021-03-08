// pour appeler le @required
import 'package:flutter/foundation.dart';

//Objet Transaction Les propriétés qui compose une transaction
class Transaction{
  final String id;
  final String title;
  final double amount;
  final DateTime date;

  //Constructor
  Transaction({
    @required this.id,
    @required this.title,
    @required this.amount,
    @required this.date,
  });
}