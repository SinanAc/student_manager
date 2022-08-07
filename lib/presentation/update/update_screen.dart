// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_data/data_base/db_functions.dart';
import 'package:student_data/model/data_model.dart';
import 'package:student_data/presentation/update/widgets/image_profile.dart';
import 'package:student_data/provider/update_provider.dart';
import '../home/home_screen.dart';

class UpdateScreen extends StatelessWidget {
  final StudentModel data;
  final int? index;
  UpdateScreen({Key? key, required this.data, required this.index})
      : super(key: key);

  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final domainController = TextEditingController();
  final contactNoController = TextEditingController();
  final ImagePicker picker = ImagePicker();

  String _imageToString = '';

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _imageToString = data.image;
      nameController.text = data.name.toString();
      ageController.text = data.age.toString();
      domainController.text = data.domain.toString();
      contactNoController.text = data.contactNo.toString();     
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Details'),
      ),
      body: Center(
        child: Form(
          child: ListView(
            padding: const EdgeInsets.only(top: 55, left: 40, right: 40),
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                    onTap: (() {
                      pickImage(context);
                    }),
                    child: ImagePro(data: data,image: _imageToString)),
              ),
              const SizedBox(
                height: 17,
              ),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  label: Text('Name'),
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              TextFormField(
                controller: ageController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  label: Text('Age'),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 7,
              ),
              TextFormField(
                controller: domainController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  label: Text('Domain'),
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              TextFormField(
                controller: contactNoController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  label: Text('Contact No'),
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(
                height: 7,
              ),
              ElevatedButton(
                onPressed: () {
                  updation(context);
                },
                child: const Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  pickImage(context) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    } else {
      final imageTemporary = File(image.path).readAsBytesSync();
      _imageToString = base64Encode(imageTemporary);
    }
    Provider.of<UpdateProvider>(context, listen: false)
        .changeName(_imageToString);
  }

  updation(BuildContext context) {
    final _name = nameController.text;
    final _age = ageController.text;
    final _domain = domainController.text;
    final _contactNo = contactNoController.text;
    final student = StudentModel(
      name: _name,
      age: _age,
      domain: _domain,
      contactNo: _contactNo,
      image: _imageToString,
    );
    if (_name.isEmpty ||
        _age.isEmpty ||
        _domain.isEmpty ||
        _contactNo.isEmpty) {
      return ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please fill all the fields',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),
        ),
      );
    } else {
      DbFunctions.updateStudent(context: context,data: student, index: index);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Updated Successfully',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (rout) => false);
    }
  }
}
