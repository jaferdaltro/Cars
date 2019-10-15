

import 'package:flutter/material.dart';

Text text(
  String s,{
  double fontSize= 16,
   color = Colors.black,
      bold =false,

}){
  return Text(
    s ?? "",
    style: TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: bold ? FontWeight.bold : FontWeight.normal,
    ),
  );
}
