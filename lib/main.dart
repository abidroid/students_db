import 'package:flutter/material.dart';
import 'package:students_db/routes/add_student.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student DB',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: AddStudent(),
    );
  }
}

