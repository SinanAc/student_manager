import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:student_data/provider/student_list.dart';
import '../model/data_model.dart';

class DbFunctions {
  static Future<void> addStudent(context, StudentModel value) async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    studentDB.add(value);
    getAllStudents(context);
  }

  static Future<void> updateStudent(
      {context, required data, required index}) async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    studentDB.putAt(index, data);
    getAllStudents(context);
  }

  static Future<void> getAllStudents(BuildContext context) async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    Provider.of<StudentListProvider>(context, listen: false)
        .addAllStudents(data: studentDB.values);
  }

  static Future<void> deleteData(context, int index) async {
    final studentDB = await Hive.openBox<StudentModel>('student_db');
    await studentDB.deleteAt(index);
    getAllStudents(context);
  }
}
