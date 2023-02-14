import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    if(Platform.isIOS){
      return const CupertinoApp(
        home: CupertinoNativeApp(),
      );
    }else {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const NativeApp(),
      );
    }
  }
}

class CupertinoNativeApp extends StatefulWidget{
  const CupertinoNativeApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return _CupertinoNative();
  }
}

class _CupertinoNative extends State<CupertinoNativeApp> {
  static const platform = MethodChannel('com.flutter.dev/calc');

  TextEditingController num1Controller =
  TextEditingController(text: 0.toString());
  TextEditingController num2Controller =
  TextEditingController(text: 0.toString());
  int? _result;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CupertinoTextField(
                controller: num1Controller,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              CupertinoTextField(
                  controller: num2Controller,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center),
              const SizedBox(
                height: 10,
              ),
              CupertinoButton(
                  child: const Text('더해보기'),
                  onPressed: () {
                    _getCalc(
                        num1Controller.value.text, num2Controller.value.text);
                  }),
              const SizedBox(
                height: 10,
              ),
              Text(_result.toString())
            ],
          ),
        ));
  }

  Future<void> _getCalc(String value1, String value2) async {
    int result;
    try {
      result = await platform
          .invokeMethod('add', [int.parse(value1), int.parse(value2)]);
    } on PlatformException catch (e) {
      result = -1;
    }
    setState(() {
      _result = result;
    });
  }

}




class NativeApp extends StatefulWidget{
  const NativeApp({super.key});

  @override
  State<StatefulWidget> createState() => _NativeApp();
}

class _NativeApp extends State<NativeApp>{
  String _deviceInfo = ''; // 나중에 네이티브 정보가 들어올 변수
  static const platform = MethodChannel('com.flutter.dev/info');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Natvie 통신 예제'),),
      body: Center(
        child: Text(_deviceInfo , style: TextStyle(fontSize: 30),),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        _getDeviceInfo();
      } , child: const Icon(Icons.get_app),),
    );
  }


  Future<void> _getDeviceInfo() async{
    String batteryLevel;
    try {
      final String result = await platform.invokeMethod('getDeviceInfo');
      batteryLevel = 'Device info : $result';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get Device info: '${e.message}'.";
    }
    setState(() {
      _deviceInfo = batteryLevel;
    });
  }
}
