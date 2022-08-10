import 'package:flutter/material.dart';
import 'package:student_data/model/data_model.dart';

class StudentListProvider extends ChangeNotifier{
  List<StudentModel> studentList=[];
  void addAllStudents({required data}){
    studentList.clear();
    studentList.addAll(data);
    notifyListeners();
  }
}