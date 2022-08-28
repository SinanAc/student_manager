import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_data/model/data_model.dart';
import 'package:student_data/view/update/update_screen.dart';
import 'package:student_data/provider/update_provider.dart';

class ShowScreen extends StatelessWidget {
  final StudentModel data;
  final int? index;
  const ShowScreen({Key? key, required this.data, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [IconButton(onPressed: () {
        Provider.of<UpdateProvider>(context, listen: false)
        .changeName(data.image); 
          Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => UpdateScreen(data: data, index: index,)));
        },
         icon: const Icon(Icons.edit))],
      ),
      body: Center(
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.only(top: 60)),
            CircleAvatar(
              backgroundImage: MemoryImage(
              const Base64Decoder().convert(data.image)),
              radius: 70,
            ),
            const SizedBox(
              height: 10,
            ),
             cardTile(Icons.person,data.name),
             cardTile(Icons.calendar_month,data.age),      
             cardTile(Icons.school,data.domain),
             cardTile(Icons.phone,data.contactNo),
          ],
        ),
      ),
    );
  }

  Card cardTile(IconData icon,String text) {
    return Card(      
                  color: Colors.white38,
                  margin:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 35.0),
                  child: ListTile(
                    leading:  Icon(
                      icon,
                      color: Colors.black54,
                    ),
                    title: Text('Name :  '+
                      text,style: textStyle(),

                    ),
                  ));
  }

   textStyle() {
    return const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
  }
}
