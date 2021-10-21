import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var gifData;
  String ff = 'hello';
  final mycontroller = TextEditingController();
  List<String> gf = List(3);
  // 'https://media.tenor.com/images/b93d7ae66e1682ed829a81ddcbf7df05/tenor.gif';

  Future<void> getGifData() async {
    gifData = await http
        .get('https://g.tenor.com/v1/search?q=$ff&key=LIVDSRZULELA&limit=3');
    var gifDataParsed = jsonDecode(gifData.body);
    setState(() {
      for (int i = 0; i < 5; i++) {
        gf[i] = gifDataParsed['results'][i]['media'][0]['gif']['url'];
      }
    });
  }

  void getDataAPI() async {
    getGifData();
  }

  @override
  void initState() {
    getGifData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Condition',
      theme: ThemeData.light(),
      home: Container(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Tenor Gif API"),
          ),
          body: Center(
            child: Column(
              children: [
                TextField(
                  controller: mycontroller,
                  decoration: InputDecoration(
                      hintText: 'Search Gif',
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
                  style: TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
                FlatButton(
                    onPressed: () async {
                      getDataAPI();
                      setState(() {
                        ff = mycontroller.text;
                      });
                    },
                    child: Text('Gif getir')),
                Container(
                  height: 480,
                  child: FractionallySizedBox(
                    heightFactor: 0.5,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: 3,
                      itemBuilder: (BuildContext context, int index) {
                        return Image(
                            fit: BoxFit.cover, image: NetworkImage(gf[index]));
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
