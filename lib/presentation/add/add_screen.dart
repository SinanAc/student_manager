// ignore_for_file: must_be_immutable
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_data/data_base/db_functions.dart';
import 'package:student_data/model/data_model.dart';
import 'package:student_data/presentation/add/widgets/image_profile.dart';
import 'package:student_data/presentation/home/home_screen.dart';
import 'package:student_data/provider/add_provider.dart';

class AddScreen extends StatelessWidget {
 AddScreen({Key? key}) : super(key: key);   

  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final domainController = TextEditingController();
  final contactNoController = TextEditingController();
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {  
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Folder'),
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
                      pickNewImage(context);
                    }),
                    child: const ImageProfile()),
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
                  submission(context);
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String imageToString = '';

  pickNewImage(context) async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    } else {
      final imageTemporary = File(image.path).readAsBytesSync();
      imageToString = base64Encode(imageTemporary);
      Provider.of<AddProvider>(context,listen: false).changeName(imageToString);
    }
  }

  submission(BuildContext context) async {
    final _name = nameController.text;
    final _age = ageController.text;
    final _domain = domainController.text;
    final _contactNo = contactNoController.text;
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
      final _student = StudentModel(
        name: _name,
        age: _age,
        domain: _domain,
        contactNo: _contactNo,
        image: imageToString,
      );
      DbFunctions.addStudent(context,_student);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Successfully Added',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        ),
      );
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (rout) => false);
    }
  }
}

