  
import 'package:flutter/material.dart';
import 'package:student_data/data_base/db_functions.dart';

class DeleteVerification{
    final BuildContext context;
    final int index;
 const DeleteVerification({Key? key, 
 required this.context,
  required this.index
  });

  deleteFunction(){
    return
   showDialog(
     context:context,
     builder:(context) {
    return AlertDialog(
      title: const Text('Alert !!'),
      content: const Text('Are you sure to want to delete ??'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('No'),
        ),
        TextButton(
        onPressed: () {    
         DbFunctions.deleteData(context,index);
         Navigator.of(context).pop();
          },
          child: const Text('Yes'),
        ),
      ],
    );
     }
   );
  }
 
  }