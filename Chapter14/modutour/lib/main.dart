import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:modutour/signPage.dart';

import 'login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // runApp 시작전에 Flutter 엔진과 위젯의 바인딩이 미리 완료!
  await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: '',
        appId: '',
        messagingSenderId: '',
        projectId: '',
        databaseURL: '',
      )
  );
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '모두의 여행',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/sign': (context) => const SignPage()
      },
    );
  }
}
