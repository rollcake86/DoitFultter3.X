import 'package:flutter/material.dart';

class Item {
  String title;
  int value;

  Item(this.title, this.value);
}

class Area {
  List<DropdownMenuItem<Item>> seoulArea = List.empty(growable: true);
  Area() {
    seoulArea.add(DropdownMenuItem(
      value: Item('강남구', 1),
      child: const Text('강남구'),
    ));
    seoulArea.add(DropdownMenuItem(
      value: Item('강동구', 2),
      child: const Text('강동구'),
    ));
    seoulArea.add(DropdownMenuItem(
      value: Item('강북구', 3),
      child: const Text('강북구'),
    ));
    seoulArea.add(DropdownMenuItem(
      value: Item('강서구', 4),
      child: const Text('강서구'),
    ));
    seoulArea.add(DropdownMenuItem(
      value: Item('관악구', 5),
      child: const Text('관악구'),
    ));
    seoulArea.add(DropdownMenuItem(
      value: Item('광진구', 6),
      child: const Text('광진구'),
    ));
    seoulArea.add(DropdownMenuItem(
      value: Item('구로구', 7),
      child: const Text('구로구'),
    ));
    seoulArea.add(DropdownMenuItem(
      value: Item('금천구', 8),
      child: const Text('금천구'),
    ));
    seoulArea.add(DropdownMenuItem(
      value: Item('노원구', 9),
      child: const Text('노원구'),
    ));
    seoulArea.add(DropdownMenuItem(
      value: Item('도봉구', 10),
      child: const Text('도봉구'),
    ));
    seoulArea.add(DropdownMenuItem(
      value: Item('동대문구', 11),
      child: const Text('동대문구'),
    ));
    seoulArea.add(DropdownMenuItem(
      value: Item('동작구', 12),
      child: const Text('동작구'),
    ));
    seoulArea.add(DropdownMenuItem(
      value: Item('마포구', 13),
      child: const Text('마포구'),
    ));
    seoulArea.add(DropdownMenuItem(
      value: Item('서대문구', 14),
      child: const Text('서대문구'),
    ));
    seoulArea.add(DropdownMenuItem(
      value: Item('서초구', 15),
      child: const Text('서초구'),
    ));
    seoulArea.add(DropdownMenuItem(
      value: Item('성동구', 16),
      child: const Text('성동구'),
    ));
    seoulArea.add(DropdownMenuItem(
      value: Item('성북구', 17),
      child: const Text('성북구'),
    ));
    seoulArea.add(DropdownMenuItem(
      value: Item('송파구', 18),
      child: const Text('송파구'),
    ));
    seoulArea.add(DropdownMenuItem(
      value: Item('양천구', 19),
      child: const Text('양천구'),
    ));
    seoulArea.add(DropdownMenuItem(
      value: Item('영등포구', 20),
      child: const Text('영등포구'),
    ));
    seoulArea.add(DropdownMenuItem(
      value: Item('용산구', 21),
      child: const Text('용산구'),
    ));
    seoulArea.add(DropdownMenuItem(
      value: Item('은평구', 22),
      child: const Text('은평구'),
    ));
    seoulArea.add(DropdownMenuItem(
      value: Item('종로구', 23),
      child: const Text('종로구'),
    ));
    seoulArea.add(DropdownMenuItem(
      value: Item('중구', 24),
      child: const Text('중구'),
    ));
    seoulArea.add(DropdownMenuItem(
      value: Item('중랑구', 25),
      child: const Text('중랑구'),
    ));
    print(seoulArea.length);
  }
}

class Kind {
  List<DropdownMenuItem<Item>> kinds = List.empty(growable: true);

  Kind() {
    kinds.add(DropdownMenuItem(
      value: Item('관광지', 12),
      child: const Text('관광지'),
    ));
    kinds.add(DropdownMenuItem(
      value: Item('문화시설', 14),
      child: const Text('문화시설'),
    ));
    kinds.add(DropdownMenuItem(
      value: Item('축제/공연', 15),
      child: const Text('축제/공연'),
    ));
    kinds.add(DropdownMenuItem(
      value: Item('여행코스', 25),
      child: const Text('여행코스'),
    ));
    kinds.add(DropdownMenuItem(
      value: Item('레포츠', 28),
      child: const Text('레포츠'),
    ));
    kinds.add(DropdownMenuItem(
      value: Item('숙박', 32),
      child: const Text('숙박'),
    ));
    kinds.add(DropdownMenuItem(
      value: Item('쇼핑', 38),
      child: const Text('쇼핑'),
    ));
    kinds.add(DropdownMenuItem(
      value: Item('음식', 39),
      child: const Text('음식'),
    ));
    kinds.add(DropdownMenuItem(
      value: Item('전체', 0),
      child: const Text('전체'),
    ));
  }
}
