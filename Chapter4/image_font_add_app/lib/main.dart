import 'package:flutter/material.dart';

import 'imageWidget.dart';

void main() => runApp(const MyApp());


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ImageWidgetApp(),
    );
  }
}

class MaterialFlutterApp extends StatefulWidget{
  const MaterialFlutterApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MaterialFlutterApp();
  }
}
class _MaterialFlutterApp extends State<MaterialFlutterApp>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Material Design App'),),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add), onPressed: (){

      }),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[Icon(Icons.android), Text('android')],
        ),
      ),
    );
  }


}
