import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransation extends StatefulWidget {
  final Function addTx;

NewTransation(this.addTx);

  @override
  _NewTransationState createState() => _NewTransationState();
}

class _NewTransationState extends State<NewTransation> {
  final titleController=TextEditingController();
  final amountController=TextEditingController();
  DateTime? _selectedDate;

  void _presentDatePicker(){
    print('***************Date Selected************************');
    showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2000), lastDate: DateTime(2022)).then((pickedDate){
      if(pickedDate==null){
        return;
      }
      setState(() {
        _selectedDate=pickedDate;
      });

    });


  }



void submitData(){
  final enteredTitle=titleController.text;
  final enteredAmount=double.parse(amountController.text);
  if(amountController.text.isEmpty){
    return;
  }
  if(enteredTitle.isEmpty || enteredAmount<=0 || _selectedDate==null){
return;}
  widget.addTx(enteredTitle,enteredAmount,_selectedDate);
  Navigator.of(context).pop();
}

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: titleController,

              decoration: InputDecoration(labelText: 'Title'),

            ),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_)=>submitData(),
              decoration: InputDecoration(labelText: 'Amount'),

            ),
            SizedBox(height: 15,),

            Row(

              children: [
                Expanded(child: Text(_selectedDate==null?'No Date Choose': 'Picked Date : ${DateFormat('dd/MM/yyyy').format(_selectedDate!)}')),
                SizedBox(width: 10,),
                TextButton(onPressed: (){_presentDatePicker();}, child: Text('Choose Date'))
              ],

            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                color:  Theme.of(context).primaryColor,
                onPressed: submitData,
                child: Text(
                  'Add Transaction',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                      color:Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 18),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

