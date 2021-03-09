import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  //Intencie
  final Function addTx;
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  NewTransaction(this.addTx,);

  //Creer un function pour l'envoie du formulaire
  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    addTx(
      enteredTitle,
      enteredAmount);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(15),
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
