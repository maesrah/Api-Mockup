import 'package:apiproject/theme.dart';

import 'package:apiproject/todos/task.preferences.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: const TaskPreference(),
    );
  }
}
