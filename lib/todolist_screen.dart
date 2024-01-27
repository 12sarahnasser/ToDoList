import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ToDoListScreen extends StatefulWidget {
  const ToDoListScreen({super.key});

  @override
  State<ToDoListScreen> createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  List<String> tasks = [];
  TextEditingController taskController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadTasks();
  }

  void loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      tasks = prefs.getStringList('tasks') ?? [];
    });
  }

  void saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('tasks', tasks);
  }

  void addTask(String task) {
    setState(() {
      tasks.add(task);
      saveTasks();
    });
  }

  void removeTask(String task) {
    setState(() {
      tasks.remove(task);
      saveTasks();
    });
  }

  void toggleTask(String task) {
    setState(() {
      int index = tasks.indexOf(task);
      tasks[index] = tasks[index].startsWith('✓')
          ? tasks[index].substring(2)
          : '✓ ${tasks[index]}';
      saveTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purpleAccent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'ToDo List',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: taskController,
              decoration: const InputDecoration(
                labelText: 'New Task',
              ),
              onSubmitted: (value) {
                addTask(value);
                taskController.clear();
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                String task = tasks[index];
                return ListTile(
                  title: Text(
                    task.startsWith('✓') ? task.substring(2) : task,
                    style: TextStyle(
                      decoration: task.startsWith('✓')
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                  trailing: IconButton(
                    focusColor: Colors.pinkAccent,
                    icon: const Icon(Icons.check),
                    onPressed: () => toggleTask(task),
                  ),
                  leading: IconButton(
                    onPressed: () => removeTask(task),
                    icon: const Icon(Icons.delete),
                  ),
                  // onLongPress: () => removeTask(task),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
