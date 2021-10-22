import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: MaterialApp(
        home: Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var gifData;
  String ff = 'hello';
  final mycontroller = TextEditingController();
  List<String> gf = List(4);
  String c;
  // 'https://media.tenor.com/images/b93d7ae66e1682ed829a81ddcbf7df05/tenor.gif';

  Future<void> getGifData() async {
    gifData = await http
        .get('https://g.tenor.com/v1/search?q=$ff&key=LIVDSRZULELA&limit=4');
    var gifDataParsed = jsonDecode(gifData.body);
    setState(() {
      for (int i = 0; i < 4; i++) {
        gf[i] = gifDataParsed['results'][i]['media'][0]['gif']['url'];
      }
    });
  }

  void getDataAPI() async {
    await getGifData();
  }

  @override
  void initState() {
    getGifData();
    print(gf);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tenor Gif API"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: TextField(
                  controller: mycontroller,
                  decoration: InputDecoration(
                      hintText: 'Search Gif',
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
                  style: TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
              ),
              FlatButton(
                  onPressed: () async {
                    setState(() {
                      gf = List(4);
                      ff = mycontroller.text;
                      FocusScope.of(context).requestFocus(new FocusNode());
                    });
                    getDataAPI();
                  },
                  child: Text('Gif getir')),
              gf[gf.length - 1] == null
                  ? Center(child: Center(child: CircularProgressIndicator()))
                  : Container(
                      height: MediaQuery.of(context).size.height * 0.9,
                      child: ListView.separated(
                        // scrollDirection: Axis.vertical,
                        itemCount: 4,
                        itemBuilder: (_, int index) {
                          return Image(
                              fit: BoxFit.cover,
                              image: NetworkImage(gf[index]));
                        },
                        separatorBuilder: (_, __) {
                          return Divider(
                            color: Colors.black38,
                            thickness: 1,
                            height: 4,
                          );
                        },
                      ),
                    )
            ],
          ),
        ),
      ),
    );
  }
}

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   var gifData;
//   String ff = 'hello';
//   final mycontroller = TextEditingController();
//   List<String> gf = List(8);
//   String c;
//   // 'https://media.tenor.com/images/b93d7ae66e1682ed829a81ddcbf7df05/tenor.gif';
//
//   Future<void> getGifData() async {
//     gifData = await http
//         .get('https://g.tenor.com/v1/search?q=$ff&key=LIVDSRZULELA&limit=8');
//     var gifDataParsed = jsonDecode(gifData.body);
//     setState(() {
//       for (int i = 0; i < 8; i++) {
//         gf[i] = gifDataParsed['results'][i]['media'][0]['gif']['url'];
//       }
//     });
//   }
//
//   void getDataAPI() async {
//     getGifData();
//   }
//
//   @override
//   void initState() {
//     getGifData();
//     print(gf);
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Weather Condition',
//       theme: ThemeData.light(),
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text("Tenor Gif API"),
//         ),
//         body: SingleChildScrollView(
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                       horizontal: 20.0, vertical: 10),
//                   child: TextField(
//                     controller: mycontroller,
//                     decoration: InputDecoration(
//                         hintText: 'Search Gif',
//                         border:
//                             OutlineInputBorder(borderSide: BorderSide.none)),
//                     style: TextStyle(fontSize: 30),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//                 FlatButton(
//                     onPressed: () async {
//                       setState(() {
//                         ff = mycontroller.text;
//                       });
//                       getDataAPI();
//                     },
//                     child: Text('Gif getir')),
//                 gf[gf.length - 1] == null
//                     ? Center(child: Center(child: CircularProgressIndicator()))
//                     : Container(
//                         height: MediaQuery.of(context).size.height * 0.7,
//                         child: ListView.separated(
//                           // scrollDirection: Axis.vertical,
//                           itemCount: 8,
//                           itemBuilder: (_, int index) {
//                             return Image(
//                                 fit: BoxFit.cover,
//                                 image: NetworkImage(gf[index]));
//                           },
//                           separatorBuilder: (_, __) {
//                             return Divider(
//                               color: Colors.blue,
//                               thickness: 5,
//                               height: 5,
//                             );
//                           },
//                         ),
//                       )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
