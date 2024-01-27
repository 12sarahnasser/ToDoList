import 'package:flutter/material.dart';

import 'todolist_screen.dart';

void main() {
  runApp(const ToDoListApp());
}

class ToDoListApp extends StatelessWidget {
  const ToDoListApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ToDoListScreen(),
    );
  }
}
