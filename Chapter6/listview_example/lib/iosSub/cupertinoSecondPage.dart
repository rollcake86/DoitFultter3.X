import 'package:flutter/cupertino.dart';

import '../animalItem.dart';

class CupertinoSecondPage extends StatefulWidget {
  final List<Animal> animalList;

  const CupertinoSecondPage({Key? key,required this.animalList}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CupertinoSecondPage();
  }
}

class _CupertinoSecondPage extends State<CupertinoSecondPage> {
  TextEditingController? _textController;
  int _kindChoice = 0;
  bool _flyExist = false;
  String? _imagePath;

  Map<int, Widget> segmentWidgets = {
    0: const SizedBox(
      width: 80,
      child: Text('양서류', textAlign: TextAlign.center),
    ),
    1: const SizedBox(
      width: 80,
      child: Text('포유류', textAlign: TextAlign.center),
    ),
    2: const SizedBox(
      width: 80,
      child: Text(
        '파충류',
        textAlign: TextAlign.center,
      ),
    )
  };

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('동물 추가'),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: CupertinoTextField(
                controller: _textController,
                keyboardType: TextInputType.text,
                maxLines: 1,
              ),
            ),
            CupertinoSegmentedControl(
                padding: const EdgeInsets.only(bottom: 20, top: 20),
                groupValue: _kindChoice,
                children: segmentWidgets,
                onValueChanged: (int? value) {
                  setState(() {
                    _kindChoice = value!;
                  });
                }),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('날개가 존재합니까?'),
                CupertinoSwitch(
                    value: _flyExist,
                    onChanged: (value) {
                      setState(() {
                        _flyExist = value;
                      });
                    })
              ],
            ),
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  GestureDetector(
                    child: Image.asset('repo/images/cow.png', width: 80),
                    onTap: () {
                      _imagePath = 'repo/images/cow.png';
                    },
                  ),
                  GestureDetector(
                    child: Image.asset('repo/images/pig.png', width: 80),
                    onTap: () {
                      _imagePath = 'repo/images/pig.png';
                    },
                  ),
                  GestureDetector(
                    child: Image.asset('repo/images/bee.png', width: 80),
                    onTap: () {
                      _imagePath = 'repo/images/bee.png';
                    },
                  ),
                  GestureDetector(
                    child: Image.asset('repo/images/cat.png', width: 80),
                    onTap: () {
                      _imagePath = 'repo/images/cat.png';
                    },
                  ),
                  GestureDetector(
                    child: Image.asset('repo/images/fox.png', width: 80),
                    onTap: () {
                      _imagePath = 'repo/images/fox.png';
                    },
                  ),
                  GestureDetector(
                    child: Image.asset('repo/images/monkey.png', width: 80),
                    onTap: () {
                      _imagePath = 'repo/images/monkey.png';
                    },
                  ),
                ],
              ),
            ),
            CupertinoButton(
                child: const Text('동물 추가하기'),
                onPressed: () {
                  widget.animalList.add(Animal(
                      animalName: _textController!.value.text,
                      kind: getKind(_kindChoice),
                      imagePath: _imagePath!,
                      flyExist: _flyExist));
                })
          ],
        ),
      ),
    );
  }

  getKind(int kindChoice) {
    switch (kindChoice) {
      case 0:
        return "양서류";
      case 1:
        return "파충류";
      case 2:
        return "포유류";
    }
  }
}
