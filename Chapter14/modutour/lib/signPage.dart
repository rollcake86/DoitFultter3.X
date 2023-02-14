import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:modutour/data/user.dart';

class SignPage extends StatefulWidget {
  const SignPage({super.key});

  @override
  State<StatefulWidget> createState() => _SignPage();
}

class _SignPage extends State<SignPage> {
  late FirebaseDatabase _database;
  late DatabaseReference reference;

  late TextEditingController _idTextController;
  late TextEditingController _pwTextController;
  late TextEditingController _pwCheckTextController;

  @override
  void initState() {
    super.initState();
    _idTextController = TextEditingController();
    _pwTextController = TextEditingController();
    _pwCheckTextController = TextEditingController();

    _database = FirebaseDatabase.instance ;
    reference = _database.ref().child('user');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('회원 가입'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 200,
              child: TextField(
                controller: _idTextController,
                maxLines: 1,
                decoration: const InputDecoration(
                    hintText: '4자 이상 입력해주세요',
                    labelText: '아이디', border: OutlineInputBorder()),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 200,
              child: TextField(
                controller: _pwTextController,
                obscureText: true,
                maxLines: 1,
                decoration: const InputDecoration(
                    hintText: '6자 이상 입력해주세요',
                    labelText: '비밀번호', border: OutlineInputBorder()),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 200,
              child: TextField(
                controller: _pwCheckTextController,
                obscureText: true,
                maxLines: 1,
                decoration: const InputDecoration(
                    labelText: '비밀번호확인', border: OutlineInputBorder()),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                if(_idTextController.value.text.length >= 4 && _pwTextController.value.text.length >= 6){
                  if (_pwTextController.value.text ==
                      _pwCheckTextController.value.text) {
                    var bytes = utf8.encode(_pwTextController.value.text);
                    var digest = sha1.convert(bytes);
                    reference
                        .child(_idTextController.value.text)
                        .push()
                        .set(User(
                        _idTextController.value.text,
                        digest.toString(),
                        DateTime.now().toIso8601String())
                        .toJson())
                        .then((_) {
                      Navigator.of(context).pop();
                    });
                  } else {
                    makeDialog('비밀번호가 틀립니다');
                  }
                }else{
                  makeDialog('길이가 짧습니다');
                }
              },
              child: const Text(
                '회원 가입',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }

  void makeDialog(String text){
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(text),
          );
        });
  }
}
