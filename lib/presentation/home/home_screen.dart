import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_data/data_base/db_functions.dart';
import 'package:student_data/presentation/search/search_screen.dart';
import 'package:student_data/provider/add_provider.dart';
import 'package:student_data/widgets/list_widget.dart';
import '../add/add_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DbFunctions.getAllStudents(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Student Details'),
          actions: [
            IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: SearchScreen());
                },
                icon: const Icon(Icons.search)),
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom:10),
          child: FloatingActionButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => AddScreen()));
                Provider.of<AddProvider>(context, listen: false).changeName('');
              },
              child: const Icon(Icons.add),
              ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,    
        body: const SafeArea(
          child: ListWidget(),
        ));
  }
}
