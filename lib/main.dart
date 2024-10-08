import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task_database.dart';
import 'package:todo_app/pages/home_page.dart';
import 'package:todo_app/theme/theme.dart';

void main() async {
  // initialize task database
  WidgetsFlutterBinding.ensureInitialized();
  await TaskDatabase.init();

  runApp(ChangeNotifierProvider(
    create: (context) => TaskDatabase(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home: const HomePage(),
    );
  }
}
