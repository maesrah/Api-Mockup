import 'package:apiproject/todos/task.controller.dart';
import 'package:apiproject/todos/task.page.dart';
import 'package:flutter/material.dart';

import 'package:apiproject/theme.dart';

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
      home: const TaskController(),
    );
  }
}

/// Requirements:
/// - Create todo [done]
/// - List todo [done]
/// - Update todo [done]
/// - Delete todo [done]
/// Store data in memory, no need to store in remote DB or local DB
