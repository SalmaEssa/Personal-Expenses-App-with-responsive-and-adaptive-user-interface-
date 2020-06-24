import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import './Transactions.dart';
class transactions_list extends StatelessWidget {
  @override
  final List<transactions> trans;
  final Function remove_transaction;
  transactions_list(this.trans,this.remove_transaction);
  
  Widget build(BuildContext context) {
    return Container(
      height: 450,

      child: trans.isEmpty? LayoutBuilder(builder:(contx, constrains){
        return Column(
        children: <Widget>[
          Text("No Transaction added yet!", style: Theme.of(context).textTheme.headline6,),
          SizedBox(height: 20,),
          Container(
            height: constrains.maxHeight*0.6,
            child:  Image.asset('assets/Images/waiting.png', fit: BoxFit.cover,),
          )
        ],
      ) ;
      }) :
       ListView.builder(itemCount: trans.length,itemBuilder: (cnx, ind){
        return Card(  
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
          elevation: 5,
          child: ListTile(leading: CircleAvatar(radius: 30,
        child: Padding(
          padding: EdgeInsets.all(6),
          child: FittedBox(child: Text('\$ ${trans[ind].amount}'),)),),
        title: Text(trans[ind].title, style: Theme.of(context).textTheme.headline6,),
        subtitle: Text(DateFormat.yMMMd().format(trans[ind].date)),
        trailing: MediaQuery.of(context).size.width<=460? IconButton(icon: Icon(Icons.delete,), 
        onPressed: ()=>remove_transaction(trans[ind].id),
        color: Theme.of(context).errorColor,):
        FlatButton.icon(onPressed:  ()=>remove_transaction(trans[ind].id), icon: Icon(Icons.delete,),
         label: Text('Delete'),
         textColor: Theme.of(context).errorColor,)
        ),
          );
          
        

      },),
    );
  }
}