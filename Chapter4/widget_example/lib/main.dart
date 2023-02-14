import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  static const String _title = 'Widget Example';

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: WidgetApp(),
    );
  }
}

class WidgetApp extends StatefulWidget {
  const WidgetApp({super.key});

  @override
  _WidgetExampleState createState() => _WidgetExampleState();
}

class _WidgetExampleState extends State<WidgetApp> {
  final List _buttonList = ['더하기', '빼기', '곱하기', '나누기'];
  final List<DropdownMenuItem<String>> _dropDownMenuItems = List.empty(growable: true);
  String? buttonText;
  String sum = '';
  TextEditingController value1 = TextEditingController();
  TextEditingController value2 = TextEditingController();

  @override
  void initState() {
    super.initState();
    for (var item in _buttonList) {
      _dropDownMenuItems.add(DropdownMenuItem(value: item, child: Text(item)));
    }
    buttonText = _dropDownMenuItems[0].value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Widget Example'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                '결과 : $sum',
                style: const TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: value1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextField(
                keyboardType: TextInputType.number,
                controller: value2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all( Colors.amber)),
                  onPressed: () {
                    setState(() {
                      var value1Int = double.parse(value1.value.text);
                      var value2Int = double.parse(value2.value.text);
                      double result;
                      if (buttonText == '더하기') {
                        result = value1Int + value2Int;
                      } else if (buttonText == '빼기') {
                        result = value1Int - value2Int;
                      } else if (buttonText == '곱하기') {
                        result = value1Int * value2Int;
                      } else {
                        result = value1Int / value2Int;
                      }
                      sum = result.toString();
                    });
                  },
                  child: Row(
                    children: <Widget>[const Icon(Icons.add), Text(buttonText!)],
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: DropdownButton(
                items: _dropDownMenuItems,
                onChanged: (String? value) {
                  setState(() {
                    buttonText = value;
                  });
                },
                value: buttonText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
