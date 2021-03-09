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
        padding: EdgeInsets.all(15),
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
            TextButton(
              child: Text(
                'Ajouter une dépense',
                style: TextStyle(
                  color: Colors.purple,
                  fontSize: 14,
                ),
              ),
              onPressed: submitData,//appel la function
            )
          ],
        ),
      )
    );
  }
}
