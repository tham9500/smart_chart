import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:smart_chair/page/load.dart';

void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: MaterialApp(
        
        debugShowCheckedModeBanner: false, //debug screen app
        theme: ThemeData(fontFamily: "Prompt"),
        title: 'smart chair',
        initialRoute: '/',
        routes: {
          '/': (context) => LoadApp_page(),
        },
      ),
    );
  }
}
