import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'memo.dart';
import 'memoAdd.dart';
import 'memoDetail.dart';

class MemoPage extends StatefulWidget {
  const MemoPage({super.key});

  @override
  State<StatefulWidget> createState() => _MemoPage();
}

class _MemoPage extends State<MemoPage> {

  static const AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );


  FirebaseDatabase? _database;
  DatabaseReference? reference;
  String _databaseURL = 'https://widgetapplication-98eee.firebaseio.com/';
  List<Memo> memos = List.empty(growable: true);
  // final FirebaseMessaging _firebaseMessaging = FirebaseMexssaging();

  BannerAd? _banner;
  bool _loadingBanner = false;

  Future<void> _createBanner(BuildContext context) async {
    final AnchoredAdaptiveBannerAdSize? size =
    await AdSize.getAnchoredAdaptiveBannerAdSize(
      Orientation.portrait,
      MediaQuery.of(context).size.width.truncate(),
    );
    if (size == null) {
      return;
    }
    final BannerAd banner = BannerAd(
      size: size,
      request: request,
      adUnitId: "", // '### 하단 배너 광고 ID ###',
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('$BannerAd loaded.');
          setState(() {
            _banner = ad as BannerAd?;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('$BannerAd failedToLoad: $error');
          ad.dispose();
        },
        onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
        onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
      ),
    );
    return banner.load();
  }


  @override
  void initState() {
    super.initState();
    _database = FirebaseDatabase(databaseURL: _databaseURL);
    reference = _database!.reference().child('memo');
    reference!.onChildAdded.listen((event) {
      print(event.snapshot.value.toString());
      setState(() {
        memos.add(Memo.fromSnapshot(event.snapshot));
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    if (!_loadingBanner) {
      _loadingBanner = true;
      _createBanner(context);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('메모 앱'),
      ),
      body:
      Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          Center(
            child: memos.isEmpty
                ? const CircularProgressIndicator()
                : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                return Card(
                  child: GridTile(
                    header: Text(memos[index].title),
                    // footer: Text(memos[index].createTime.substring(0, 10)),
                    child: Container(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: SizedBox(
                        child: GestureDetector(
                          onTap: () async {

                            Memo? memo = await Navigator.of(context).push(
                                MaterialPageRoute<Memo>(
                                    builder: (BuildContext context) =>
                                        MemoDetailPage(
                                            reference!, memos[index])));
                            if (memo != null) {
                              setState(() {
                                memos[index].title = memo.title;
                                memos[index].content = memo.content;
                              });
                            }
                          },
                          onLongPress: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(memos[index].title),
                                    content: const Text('삭제하시겠습니까?'),
                                    actions: <Widget>[
                                      ElevatedButton(
                                          onPressed: () {
                                            reference!
                                                .child(memos[index].key!)
                                                .remove()
                                                .then((_) {
                                              setState(() {
                                                memos.removeAt(index);
                                                Navigator.of(context).pop();
                                              });
                                            });
                                          },
                                          child: const Text('예')),
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('아니요')),
                                    ],
                                  );
                                });
                          },
                          child: Text(memos[index].content),
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount: memos.length,
            ),
          ),
          if (_banner != null)
            Container(
              color: Colors.green,
              width: _banner!.size.width.toDouble(),
              height: _banner!.size.height.toDouble(),
              child: AdWidget(ad: _banner!),
            ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => MemoAddApp(reference!)));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _banner?.dispose();
  }
}

