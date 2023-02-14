import 'package:flutter/material.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sql_example/todo.dart';

class ClearListApp extends StatefulWidget {
  Future<Database> database;
  ClearListApp(this.database, {super.key});
  @override
  State<StatefulWidget> createState() => _ClearListApp();
}

class _ClearListApp extends State<ClearListApp> {
  Future<List<Todo>>? clearList;

  @override
  void initState() {
    super.initState();
    clearList = getClearList();

  }


  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        title: const Text('이미 한일'),
      ),
      body: Center(
        child: FutureBuilder(
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const CircularProgressIndicator();
              case ConnectionState.waiting:
                return const CircularProgressIndicator();
              case ConnectionState.active:
                return const CircularProgressIndicator();
              case ConnectionState.done:
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      Todo todo = (snapshot.data as List<Todo>)[index];
                      return ListTile(
                        title: Text(
                          todo.title!,
                          style: const TextStyle(fontSize: 20),
                        ),
                        subtitle: Column(
                          children: <Widget>[
                            Text(todo.content!),
                            Container(
                              height: 1,
                              color: Colors.blue,
                            )
                          ],
                        ),
                      );
                    },
                    itemCount: (snapshot.data as List<Todo>).length,
                  );
                }
            }
            return const Text('No data');
          },
          future: clearList,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('완료한 일 삭제'),
                  content: const Text('완료한 일을 모두 삭제할까요?'),
                  actions: <Widget>[
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: const Text('예')),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: const Text('아니요')),
                  ],
                );
              });
          if (result == true) {
            _removeAllTodos();
          }
        },
        child: const Icon(Icons.remove),
      ),
    );
  }

  Future<List<Todo>> getClearList() async {
    final Database database = await widget.database;
    List<Map<String, dynamic>> maps = await database
        .rawQuery('select title, content, id from todos where active=1');

    return List.generate(maps.length, (i) {
      return Todo(
          title: maps[i]['title'].toString(),
          content: maps[i]['content'].toString(),
          id: maps[i]['id']);
    });
  }

  void _removeAllTodos() async {
    final Database database = await widget.database;
    database.rawDelete('delete from todos where active=1');
    setState(() {
      clearList = getClearList();
    });
  }
}
