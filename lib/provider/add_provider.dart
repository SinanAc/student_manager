import 'package:flutter/material.dart';

class AddProvider extends ChangeNotifier {
  String image = '';
  void changeName(String value){
    image = value;
    notifyListeners();
  }
}