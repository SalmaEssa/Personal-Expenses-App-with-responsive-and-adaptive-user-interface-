import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveFlateButton extends StatelessWidget {
  final text;
  final Function handller;
  AdaptiveFlateButton(this.text,this.handller);
  @override
  Widget build(BuildContext context) {
    return  Platform.isIOS?CupertinoButton(child: Text(text, style: TextStyle(fontWeight: FontWeight.bold),),
                 
                 onPressed: handller,) 
                  :FlatButton(child: Text(text, style: TextStyle(fontWeight: FontWeight.bold),),
                 textColor: Theme.of(context).primaryColor,
                 onPressed: handller,
                 );
  }
}