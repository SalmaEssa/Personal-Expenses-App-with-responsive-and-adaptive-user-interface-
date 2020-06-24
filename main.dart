import 'dart:ui';
import 'dart:io';
import 'package:PersonalExpenses_App/chart.dart';
import 'package:PersonalExpenses_App/new_transactions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import './Transactions.dart';
import './transactions_list.dart';
import './chart.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      home: MyHomePage(),
      theme: ThemeData(primarySwatch: Colors.purple,accentColor: Colors.amber,fontFamily: 'Quicksand',
      appBarTheme: AppBarTheme(textTheme: ThemeData.light().textTheme.copyWith(
        headline6: TextStyle(fontFamily: 'OpenSans', fontSize: 20,fontWeight: FontWeight.bold)
      )),
      textTheme: ThemeData.light().textTheme.copyWith(
        headline6: TextStyle(fontFamily: 'OpenSans', fontSize: 20,fontWeight: FontWeight.bold),
        button: TextStyle(color: Colors.white)
      )
    )
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _show_chart=false;

 final List<transactions> _trans=[
    transactions(amount: 69.99,date: DateTime.now(), id: "t1",title: "new shoes"),
    transactions(amount: 16.53,date: DateTime.now(), id: "t2",title: "weekly Groceries"),

  ];
 
 //final List<transactions> trans=[];
void _remove_transaction(String id){
  setState(() {
    _trans.removeWhere((element) => element.id==id);

  });
}
  void _add_new_trans(String tit , double amou,DateTime new_date){
   final tx= transactions(amount: amou,date:new_date ,id: DateTime.now().toString(),title: tit);
   print(tx.amount);
    print(tx.title);

   setState(() {  _trans.add(tx);
      
    }); 
  }
  List<transactions> get  recent_trans{
   return _trans.where((e) {
return e.date.isAfter(DateTime.now().subtract(Duration(days: 7)));

   }).toList();
 }

   
    void _start_showing_list(BuildContext ctx)
    {  

      showModalBottomSheet(context: ctx, builder:(tx)
      {
        return GestureDetector(child:
        new_transactions(_add_new_trans),

        onTap: (){},behavior: HitTestBehavior.opaque,
        );

      });
    }
 
  @override
  Widget build(BuildContext context) {
      final PreferredSizeWidget app_bar=Platform.isIOS?CupertinoNavigationBar(
        middle:Text('Personal Expenses'), 
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[

            GestureDetector(
              child: Icon(CupertinoIcons.add),
              onTap: ()=>_start_showing_list(context),
            )
          ],
        )
      )  :AppBar(
        title: Text('Personal Expenses'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.add), onPressed:()=>_start_showing_list(context)),
        ],
      );
    final  media_query=MediaQuery.of(context);
    final is_portrait=media_query.orientation==Orientation.portrait;
      final body=SingleChildScrollView(
              child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if(!is_portrait)
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Show Chart',style: Theme.of(context).textTheme.headline6,),
                Switch.adaptive (value: _show_chart, onChanged: (val){
                       setState(() {
                         _show_chart=val;
                       });
                }),
              ],
            ),
            if(!is_portrait)
          _show_chart==true?
         Container(
           height: (media_query.size.height-app_bar.preferredSize.height-media_query.padding.top)*0.7,
           child: chart(recent_trans)):
         Container(
           height: (media_query.size.height-app_bar.preferredSize.height-media_query.padding.top)*0.6,
           child: transactions_list(_trans,_remove_transaction)),
         if(is_portrait)
        Container(
           height: (media_query.size.height-app_bar.preferredSize.height-media_query.padding.top)*0.4,
           child: chart(recent_trans)),
           if(is_portrait)
         Container(
           height: (media_query.size.height-app_bar.preferredSize.height-media_query.padding.top)*0.6,
           child: transactions_list(_trans,_remove_transaction))

        
        ],
        
        ),
      );
  
    return Platform.isIOS? CupertinoPageScaffold(child:body,
    navigationBar: app_bar ,
    ) : Scaffold(
      appBar: app_bar,
      body:body
    
      , floatingActionButton:Platform.isIOS? Container() : FloatingActionButton(child: Icon(Icons.add), onPressed: ()=>_start_showing_list(context),),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
