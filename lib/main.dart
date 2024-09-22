import 'package:flutter/material.dart';
import 'package:todo_app/page/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'To Do List',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}