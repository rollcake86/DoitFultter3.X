import 'package:flutter/material.dart';


class SecondDetail extends StatelessWidget {
  const SecondDetail({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Page'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            TextField(
              controller: controller,
              keyboardType: TextInputType.text,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(controller.value.text);
              },
              child: const Text('Todo 저장하기'),
            ),
          ],
        ),
      ),
    );
  }
}
