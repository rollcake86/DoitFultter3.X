import 'package:flutter/material.dart';

class ThirdDetail extends StatelessWidget {
  const ThirdDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final String args = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Third Page'),
      ),
      body: Center(
        child: Text(args , style: const TextStyle(fontSize: 30),),
      ),
    );
  }
}
