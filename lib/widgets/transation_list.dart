import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expense_tracker/models/transation.dart';

class TransationList extends StatefulWidget {
  List<Transation> transations;
  final Function delTx;

  TransationList(this.transations, this.delTx);

  @override
  _TransationListState createState() => _TransationListState();
}

class _TransationListState extends State<TransationList> {


  @override
  Widget build(BuildContext context) {
    return widget.transations.isEmpty ? LayoutBuilder(
        builder: (cxt, constraints) {
          return Column(children: [
            SizedBox(height: 10,),
            Text('OOps! No Data Yet!! ', style: Theme
                .of(context)
                .textTheme
                .bodyText1,),
            SizedBox(height: 15,),
            Container(
                height: constraints.maxHeight * 0.6,
                child: Image.asset('assets/list.jpeg', fit: BoxFit.cover,))

          ],);
        }

    ) : ListView.builder(
        itemCount: widget.transations.length,
        itemBuilder: (ctx, index) {
          return Card(
            elevation: 3.0,
            child: Padding(
                padding: EdgeInsets.all(5.0),

                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 30,
                    child: Text(
                      '${widget.transations[index].amount.toStringAsFixed(2)}',
                      style: TextStyle(fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                          color: Colors.white),),
                  ),
                  title: Text('${widget.transations[index].title}', style: Theme
                      .of(context)
                      .textTheme
                      .bodyText1,),
                  subtitle: Text('${DateFormat('dd/MM/yyyy').format(
                      widget.transations[index].dateTime)}',
                    style: TextStyle(fontWeight: FontWeight.w700),),
                  trailing: MediaQuery
                      .of(context)
                      .size
                      .width > 420 ? TextButton(

                      onPressed: () {
                        widget.delTx(widget.transations[index].id);
                      },
                      child: Text(
                          'Delete', style: TextStyle(color: Colors.white))
                  ) : IconButton(color: Theme
                      .of(context)
                      .errorColor, icon: Icon(Icons.delete), onPressed: () {
                    widget.delTx(widget.transations[index].id);
                  },),
                )),
          );
        }

    );
  }
}
