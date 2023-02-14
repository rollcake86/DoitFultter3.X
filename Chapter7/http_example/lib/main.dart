import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HttpApp(),
    );
  }
}

class HttpApp extends StatefulWidget {
  const HttpApp({super.key});

  @override
  State<StatefulWidget> createState() => _HttpApp();
}

class _HttpApp extends State<HttpApp> {
  String result = '';
  TextEditingController? _editingController;
  ScrollController? _scrollController;
  List? data;
  int page = 1;

  @override
  void initState() {
    super.initState();
    data = List.empty(growable: true);
    _editingController = TextEditingController();
    _scrollController = ScrollController();
    _scrollController!.addListener(() {
      if (_scrollController!.offset >=
          _scrollController!.position.maxScrollExtent &&
          !_scrollController!.position.outOfRange) {
        print('bottom');
        page++;
        getJSONData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _editingController,
          style: const TextStyle(color: Colors.white),
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(hintText: '검색어를 입력하세요'),
        ),
      ),
      body: Center(
        child: data!.isEmpty
            ? const Text(
          '데이터가 존재하지 않습니다.\n검색해주세요',
          style: TextStyle(fontSize: 20),
          textAlign: TextAlign.center,
        )
            : ListView.builder(
          itemBuilder: (context, index) {
            print(data![index]['thumbnail']);
            return Card(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  if(data?[index]['thumbnail'] != '')
                    Image.network(
                      data![index]['thumbnail'],
                      height: 100,
                      width: 100,
                      fit: BoxFit.contain,
                    ) else const SizedBox(  height: 100,
                    width: 100,),
                  Column(
                    children: <Widget>[
                      SizedBox(
                        width:
                        MediaQuery.of(context).size.width - 150,
                        child: Text(
                          data![index]['title'].toString(),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Text(
                          '저자 : ${data![index]['authors'].toString()}'),
                      Text(
                          '가격 : ${data![index]['sale_price'].toString()}'),
                      Text(
                          '판매중 : ${data![index]['status'].toString()}'),
                    ],
                  )
                ],
              ),
            );
          },
          itemCount: data!.length,
          controller: _scrollController,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          page = 1;
          data!.clear();
          getJSONData();
        },
        child: const Icon(Icons.search),
      ),
    );
  }

  Future<String> getJSONData() async {
    var url =
        'https://dapi.kakao.com/v3/search/book?target=title&page=$page&query=${_editingController!.value.text}';

    var response = await http.get(Uri.parse(url),
        headers: {"Authorization": "KakaoAK aa51bf3d875ea350a1d8bd05de36d8b8"});

    print(response.body); // 검색 결과 로그창으로 확인

    setState(() {
      var dataConvertedToJSON = json.decode(response.body);
      List result = dataConvertedToJSON['documents'];
      data!.addAll(result);
    });
    return response.body;
  }
}
