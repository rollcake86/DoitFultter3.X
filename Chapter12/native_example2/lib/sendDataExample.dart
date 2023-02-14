import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SendDataExample extends StatefulWidget {
  const SendDataExample({super.key});

  @override
  State<StatefulWidget> createState() => _SendDataExample();
}

class _SendDataExample extends State<SendDataExample> {
  static const platform = MethodChannel('com.flutter.dev/encryto');

  TextEditingController controller = TextEditingController(text: '안녕하세요  flutter');
  String _changeText = 'Nothing';
  String _reChangedText = 'Nothing';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Data Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: controller,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              _changeText,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                _decodeText(_changeText);
              },
              child: const Text('디코딩 하기'),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              _reChangedText,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _sendData(controller.value.text);
        },
        child: const Text('변환'),
      ),
    );
  }

  Future<void> _sendData(String text) async {
    final String result = await platform.invokeMethod('getEncryto', text);
    print(result);
    setState(() {
      _changeText = result;
    });
  }

  void _decodeText(String changeText) async{
    final String result = await platform.invokeMethod('getDecode', changeText);
    setState(() {
      _reChangedText = result;
    });
  }
}
