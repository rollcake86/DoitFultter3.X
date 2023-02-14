import 'package:flutter/material.dart';

import 'intro.dart';
import 'people.dart';
import 'secondPage.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const IntroPage(),
    );
  }
}

class AnimationApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AnimationApp();
}

class _AnimationApp extends State<AnimationApp> {

  List<People> peoples = List.empty(growable: true);
  int current = 0;
  Color weightColor = Colors.blue;
  double _opacity = 1;

  @override
  void initState() {
    peoples.add(People('스미스', 180, 92));
    peoples.add(People('메리', 162, 55));
    peoples.add(People('존', 177, 75));
    peoples.add(People('바트', 130, 40));
    peoples.add(People('콘', 194, 140));
    peoples.add(People('디디', 100, 80));
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation Example'),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AnimatedOpacity(
                opacity: _opacity,
                duration: const Duration(seconds: 1),
                child:

                SizedBox(
                  height: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(width: 100, child: Text('이름 : ${peoples[current].name}')),
                      AnimatedContainer(
                        duration: const Duration(seconds: 2),
                        curve: Curves.bounceIn,
                        color: Colors.amber,
                        width: 50,
                        height: peoples[current].height,
                        child: Text(
                          '키 ${peoples[current].height}',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      AnimatedContainer(
                        duration: const Duration(seconds: 2),
                        curve: Curves.easeInCubic,
                        color: weightColor,
                        width: 50,
                        height: peoples[current].weight,
                        child: Text(
                          '몸무게 ${peoples[current].weight}',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      AnimatedContainer(
                        duration: const Duration(seconds: 2),
                        curve: Curves.linear,
                        color: Colors.pinkAccent,
                        width: 50,
                        height: peoples[current].bmi,
                        child: Text(
                          'bmi ${peoples[current].bmi.toString().substring(0, 2)}',
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (current < peoples.length - 1) {
                      current++;
                    }
                    _changeWeightColor(peoples[current].weight);
                  });
                },
                child: const Text('다음'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (current > 0) {
                      current--;
                    }
                    _changeWeightColor(peoples[current].weight);
                  });
                },
                child: const Text('이전'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _opacity == 1 ? _opacity = 0 : _opacity = 1;
                  });
                },
                child: const Text('사라지기'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder:
                      (context) => SecondPage()));
                },
                child: SizedBox(
                  width: 200,
                  child: Row(
                    children: const <Widget>[
                      Hero(tag: 'detail', child: Icon(Icons.cake)),
                      Text('이동하기')
                    ],
                  ),),),

            ],
          ),),),
    );
  }

  void _changeWeightColor(double weight) {
    if (weight < 40) {
      weightColor = Colors.blueAccent;
    } else if (weight < 60) {
      weightColor = Colors.indigo;
    } else if (weight < 80) {
      weightColor = Colors.orange;
    } else {
      weightColor = Colors.red;
    }
  }

}
