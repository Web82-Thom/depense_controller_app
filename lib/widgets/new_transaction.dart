import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  //Intencie
  final Function addTx;

  NewTransaction(this.addTx,);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }

    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    
    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,  
    );
    
    Navigator.of(context).pop();
  }

  //Affichage du selecteur de date
  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(), 
      firstDate: DateTime(2015), 
      lastDate: DateTime.now(),
      locale : const Locale("fr","FR"),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      //setState Renvoie à dart l'état
      setState(() {
        _selectedDate = pickedDate;
      });
      
    });
    print('...');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      
          child: Card(
        elevation: 5,
        child: Container(
          // margin: EdgeInsets.all(0),
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 50,
          ),
          // height: 5000,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  labelText: 'Titre',
                ),
                controller: _titleController,
                onSubmitted: (_) => _submitData(), //appel la function
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Prix',
                ),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData(), //appel la function 
              ),
              Container(
                height: 80,
                child: Row(
                  children: <Widget>[
                    Expanded(
                                        child: Text(_selectedDate == null 
                        ? 'Pas de date selectionner!' 
                        : DateFormat.yMMMMEEEEd('fr').format(_selectedDate),
                      ),
                    ),
                    TextButton(
                      child: Text(
                        'Choisissez une date',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: _presentDatePicker,//appel la function
                    ),
                  ],
                ),
              ),
              Container(
                color: Theme.of(context).primaryColor,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10,),
                  child: TextButton(
                    child: Text(
                      'Ajouter une dépense',
                      style: TextStyle(
                        color: Theme.of(context).textTheme.button.color,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    onPressed: _submitData,//appel la function
                  ),
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
