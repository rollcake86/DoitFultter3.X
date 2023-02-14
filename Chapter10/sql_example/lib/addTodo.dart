import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';

import 'todo.dart';

class AddTodoApp extends StatefulWidget {
  final Future<Database> db;

  const AddTodoApp(this.db, {super.key});

  @override
  State<StatefulWidget> createState() => _AddTodoApp();
}

class _AddTodoApp extends State<AddTodoApp> {
  TextEditingController? titleController;
  TextEditingController? contentController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    contentController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo 추가'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: '제목'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: contentController,
                decoration: const InputDecoration(labelText: '할일'),
              ),
            ),
            ElevatedButton(
              onPressed: (){
                Todo todo = Todo(
                    title: titleController!.value.text,
                    content: contentController!.value.text,
                    active: 0);
                Navigator.of(context).pop(todo);
              },
              child: const Text('저장하기'),
            )
          ],
        ),
      ),
    );
  }
}
