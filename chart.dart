
import 'package:PersonalExpenses_App/Transactions.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './Transactions.dart';
import './bar_chart.dart';

class chart extends StatelessWidget { 
  final List<transactions> trans;
  chart(this.trans); 
  List<Map<String,Object>> get groupedTransactionValues{
   return List.generate(7, (index) {
     final day=DateTime.now().subtract(Duration(days: index));
     double amount=0;
     for (int i=0 ; i<trans.length; ++i)
     {
       if(trans[i].date.year==day.year &&trans[i].date.month==day.month &&trans[i].date.day==day.day ){
         amount+=trans[i].amount; 
       }
     }
  return { 'day': DateFormat.E().format(day).substring(0,1), 'amount':amount};
   }).reversed.toList();

  }
  double get total_spending_amount{
   return groupedTransactionValues.fold(0.0, (previousValue, element) {
     return previousValue+element['amount'];
   });
 }
  @override
  Widget build(BuildContext context) {
    //print(groupedTransactionValues);
    return Card( 
      margin: EdgeInsets.all(20),  
      elevation: 6, 
      child: Row(
          children: groupedTransactionValues.map((e) {
            return Flexible(
              fit: FlexFit.tight,
              child: bar_chart(e['amount'],e['day'],total_spending_amount==0? 0: (e['amount'] as double)/total_spending_amount));
          },
      ).toList(),
    ),
    );
  }
}