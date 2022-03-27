import 'package:final_620710732/models/api.dart';
import 'package:final_620710732/pages/games/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
  //Api().fetch("quizzes");
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

