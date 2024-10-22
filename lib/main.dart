import 'package:flutter/material.dart';
import 'package:mx_player/first_page/first_page.dart';
import 'package:mx_player/provider/provider.dart';
import 'package:mx_player/song_page/song_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(myApp());
}

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MxPlayerProvider(),
      builder: (context, child) => MaterialApp(
        routes: {
          '/': (context) => firstPage(),
          '/song': (context) => songPage()
        },
      ),
    );
  }
}
