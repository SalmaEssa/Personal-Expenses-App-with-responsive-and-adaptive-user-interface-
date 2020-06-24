import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import './Adaptive_Flate_Button.dart';

import 'dart:io';

class new_transactions extends StatefulWidget {
  final Function fun;
  new_transactions(this.fun);

  @override
  _new_transactionsState createState() => _new_transactionsState();
}

class _new_transactionsState extends State<new_transactions> {
  final _title_controller=TextEditingController();

  final _amount_controller=TextEditingController();
  DateTime _date;

  void _pressentDatePicker(){

  showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2019), 
  lastDate: DateTime.now()).then((d) {
   if (d==null)
   return ; 
   setState(() {
      _date=d;

   });
  });
  }

   void _submitt(){
final tit=_title_controller.text;
if (_amount_controller.text.isEmpty)
return;
final amou=double.parse(_amount_controller.text);

if(tit.isEmpty || amou<=0||_date==null)
return ; 
widget.fun(tit,amou,_date)  ;
 Navigator.of(context).pop();
   }

  @override
  Widget build(BuildContext context) {
    // print("hhhhhhhhhhh");
    // print(MediaQuery.of(context).viewInsets.top);
    return Card(
           elevation: 5,
           child: Container(
             padding: EdgeInsets.only(
               top: 10,left: 10,right: 10,
               bottom: MediaQuery.of(context).viewInsets.top +100
             ),
             child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(decoration: InputDecoration(labelText: 'Title'),
             controller: _title_controller,
             onSubmitted:(_)=>_submitt() ,

              ),
              TextField(decoration: InputDecoration(labelText: 'Amount'), controller: _amount_controller,
              keyboardType:TextInputType.number,
              onSubmitted:(_)=>_submitt() ,
              ),
              Container(
             height: 70,
             child: Row(
               children: <Widget>[
                 Expanded(child: Text(_date==null?'No date chosen!': 'Picked Date: ${DateFormat.yMd().format(_date)}')),
               AdaptiveFlateButton('Choose Date',_pressentDatePicker),
               ],
             ),
              ),
              RaisedButton(child: Text("Add Transaction"),onPressed:_submitt, 
              color:Theme.of(context).primaryColor,
              textColor: Theme.of(context).textTheme.button.color,
              
              )
            ],

             ),
           ),
        ) ;
  }
}