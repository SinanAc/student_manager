import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:student_data/model/data_model.dart';
import 'package:student_data/presentation/splash/splash_screen.dart';
import 'package:student_data/provider/add_provider.dart';
import 'package:student_data/provider/student_list.dart';
import 'package:student_data/provider/update_provider.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(StudentModelAdapter().typeId)) {
    Hive.registerAdapter(StudentModelAdapter());
  }
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AddProvider()),
        ChangeNotifierProvider(create: (context) => UpdateProvider()),
        ChangeNotifierProvider(create: (context) => StudentListProvider()),
      ],
      child :    
     MaterialApp(
      theme: ThemeData(primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    )
    );
  }
}

