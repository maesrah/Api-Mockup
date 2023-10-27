import 'package:apiproject/todos/todo.controller.dart';
import 'package:flutter/material.dart';

import 'package:apiproject/screen/dashboard_page.dart';
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
      home: const TodoAppController(),
    );
  }
}

/// Requirements:
/// - Create todo [done]
/// - List todo [done]
/// - Update todo [done]
/// - Delete todo [done]
/// Store data in memory, no need to store in remote DB or local DB
