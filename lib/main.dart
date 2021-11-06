import 'package:expense_tracker/widgets/chart.dart';
import 'package:expense_tracker/widgets/new_transation.dart';
import 'package:expense_tracker/widgets/transation_list.dart';


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'models/transation.dart';

void main() {
 /* WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]
  );*/
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red,
        fontFamily: 'Roboto',
        textTheme: ThemeData.light().textTheme.copyWith(bodyText1: TextStyle(fontFamily: 'IndieFlower',fontSize: 20,fontWeight: FontWeight.w700)),
        appBarTheme: AppBarTheme(
            textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                )),
        // ignore: deprecated_member_use
        accentColor: Colors.redAccent,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Transation> _usertransations = [
    Transation(
        id: "01", title: "Snack", amount: 22.0, dateTime: DateTime.now()),
    Transation(
        id: "02", title: "Phone", amount: 45.0, dateTime: DateTime.now()),
  ];

  List<Transation> get _recentTransations{
    return _usertransations.where((tx) => tx.dateTime.isAfter(DateTime.now().subtract(Duration(days: 7)))).toList();
  }
  void _addNewTransation(String txtitle, double txamount,DateTime choosenDate) {
    final newTx = Transation(
        id: DateTime.now().toString(),
        title: txtitle,
        amount: txamount,
        dateTime: choosenDate);
    setState(() {
      _usertransations.add(newTx);
    });
  }

  void _startAddNewTransation(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            child: NewTransation(_addNewTransation),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deleteTransation(String id){
    setState(() {
      _usertransations.removeWhere((tx)=>tx.id==id);
    });
  }

  bool _showChart=true;

  @override
  Widget build(BuildContext context) {
    final mediaquery=MediaQuery.of(context);
    final isLandscape=mediaquery.orientation==Orientation.landscape;
    final appBar= AppBar(
      title: Text(
        'Expense Tracker',
      ),
    );
    final txListWid=Container(
        height: (mediaquery.size.height-appBar.preferredSize.height)*0.7,
        child:  TransationList(_usertransations,_deleteTransation));
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar:appBar,
        body: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
          if(isLandscape)    Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Show Chart'),
                  Switch(value: _showChart, onChanged: (val){
                    setState(() {
                      _showChart=_showChart?false:true;
                    });
                  })
                ],
              ),
        if(!isLandscape) Container(
        height: (mediaquery.size.height-appBar.preferredSize.height-MediaQuery.of(context).padding.top)*0.28,
    child:Chart(_recentTransations)),
        if(!isLandscape) txListWid,
     if(isLandscape)   _showChart?  Container(
          height: (mediaquery.size.height-appBar.preferredSize.height-MediaQuery.of(context).padding.top)*0.7,
          child:Chart(_recentTransations))

     : txListWid
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            _startAddNewTransation(context);
          },
        ),
      ),
    );
  }
}
