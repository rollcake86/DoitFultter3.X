// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_app/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    // await tester.pumpWidget(const MyApp());
    //
    // // Verify that our counter starts at 0.
    // expect(find.text('0'), findsOneWidget);
    // expect(find.text('1'), findsNothing);
    //
    // // Tap the '+' icon and trigger a frame.
    // await tester.tap(find.byIcon(Icons.add));
    // await tester.pump();
    //
    // // Verify that our counter has incremented.
    // expect(find.text('0'), findsNothing);
    // expect(find.text('1'), findsOneWidget);


    Car bmw = Car(320, 100000, 'BMW');
    Car toyota = Car(250, 70000, 'BENZ');
    Car ford = Car(200, 80000, 'FORD');
    bmw.saleCar();
    bmw.saleCar();
    bmw.saleCar();
    print(bmw.price);

  });
}



class Car {
  int? maxSpeed;
  num? price;
  String? name;
  Car(int this.maxSpeed , num this.price , String this.name);
  num? saleCar(){
    price = price! * 0.9 ;
    return price;
  }
}