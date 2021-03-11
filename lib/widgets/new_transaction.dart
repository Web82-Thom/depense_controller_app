import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  //Intencie
  final Function addTx;

  NewTransaction(this.addTx,);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount);
    
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        // margin: EdgeInsets.all(0),
        padding: EdgeInsets.all(5),
        height: 1000,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'Titre',
              ),
              controller: titleController,
              onSubmitted: (_) => submitData(), //appel la function
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Prix',
              ),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(), //appel la function 
            ),
            Container(
              height: 80,
              child: Row(
                children: <Widget>[
                  Text('Pas de date selectionner!'),
                  TextButton(
                    child: Text(
                      'Choisissez une date',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {},//appel la function
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
                  onPressed: submitData,//appel la function
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
