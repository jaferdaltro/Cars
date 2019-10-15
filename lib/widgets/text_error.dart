import 'package:flutter/material.dart';

class TextError extends StatelessWidget {
  String text;


  TextError(this.text);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(text),
    );
  }
}
