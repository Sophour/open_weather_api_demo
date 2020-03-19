import 'package:flutter/material.dart';

class ErrorSnackBar{
  final String _errorMessage;
  final BuildContext _context;

  ErrorSnackBar(this._errorMessage, this._context);

  show() async {
    Scaffold.of(_context).showSnackBar(SnackBar(
      duration: Duration(seconds: 6),
      content: Text(
        _errorMessage,
        style: TextStyle( color: Colors.pink[200] ),
      ),
    ));

  }


}