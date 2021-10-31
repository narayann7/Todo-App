import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/all_constant.dart';
import 'package:todoapp/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyTodoApp());
}

class MyTodoApp extends StatelessWidget {
  const MyTodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();
    return MaterialApp(
      theme: ThemeData(
        colorScheme: theme.colorScheme.copyWith(
            primaryVariant: black, secondary: black, onPrimary: black),
      ),
      home: HomePage(),
    );
  }
}
