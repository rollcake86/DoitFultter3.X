import 'package:flutter/material.dart';
import 'package:todo_list/subDetail.dart';
import 'package:todo_list/thirdDetail.dart';
import 'secondDetail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  static const String _title = 'Widget Example';

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blue
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SubDetail(),
        '/second' : (context) => const SecondDetail(),
        '/third' : (context) => const ThirdDetail(),
      },
    );
  }
}

class SubMain extends StatefulWidget {
  const SubMain({super.key});

  @override
  State<StatefulWidget> createState() => _SubMain();
}

class _SubMain extends State<SubMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sub Page Main'),
      ),
      body: const Center(
        child: Text('첫번째 페이지'),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const SecondPage()));
      } , child: const Icon(Icons.add),),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Page'),
      ),
      body: Container(
        child: Center(
          child: MaterialButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('돌아가기'),
          ),
        ),
      ),
    );
  }
}
