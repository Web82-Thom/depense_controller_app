import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  //Intencie
  final Function addTx;
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  NewTransaction(this.addTx,);

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
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Prix',
              ),
              controller: amountController,
            ),
            TextButton(
              child: Text(
                'Ajouter une dépense',
                style: TextStyle(
                  color: Colors.purple,
                  fontSize: 14,
                ),
              ),
              onPressed: () {
                print(titleController.text);
                print(amountController.text);
                addTx(
                  titleController.text,
                  double.parse(amountController.text));
              },
            )
          ],
        ),
      )
    );
  }
}
