import 'package:apiproject/theme.dart';
import 'package:apiproject/todos/task.controller.dart';
import 'package:apiproject/todos/task_provider.dart';
import 'package:apiproject/todos/trypage.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: const MyApp(),
    ),
  );
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
      home: const TryAppPage(),
    );
  }
}
