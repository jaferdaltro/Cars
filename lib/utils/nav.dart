import 'package:flutter/material.dart';

Future push(BuildContext ctx, Widget page, {bool replace = false}) {
  if( replace){
    return Navigator.pushReplacement(ctx, MaterialPageRoute(builder: (BuildContext context) {
      return page;
    }));
  }

  return Navigator.push(ctx, MaterialPageRoute(builder: (BuildContext context) {
    return page;
  }));
}
