import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mx_player/first_page/first_page.dart';
import 'package:mx_player/first_page/serachPage/searchPage.dart';
import 'package:mx_player/likePage/likePage.dart';
import 'package:mx_player/newPage/newPage.dart';
import 'package:mx_player/provider/provider.dart';
import 'package:mx_player/provider/serach_provider/ser_provider.dart';
import 'package:mx_player/song_page/song_page.dart';
import 'package:mx_player/splesh/splesh.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(myApp());
}

class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
        create: (context) => MxPlayerProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SearchProvider(),
        ),
      ],
      child:
         MaterialApp(
           debugShowCheckedModeBanner: false,
          routes: {
         //   '/':(context)=>newPage(),
            '/': (context) => SpleshPage(),
            '/home':(context)=>firstPage(),
            '/song': (context) => songPage(),
            '/like':(context)=>likePage(),
            '/ser':(context)=>searchPage()
          },
        ),

    );
  }
}
