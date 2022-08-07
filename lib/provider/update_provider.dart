import 'package:flutter/material.dart';

class UpdateProvider extends ChangeNotifier {
  String image = '';
  void changeName(String value){
    image = value;
    notifyListeners();
  }
}