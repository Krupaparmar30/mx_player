import 'package:flutter/material.dart';
import 'package:mx_player/first_page/first_page.dart';
import 'package:so_simple_splash/so_simple_splash.dart';

class SpleshPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Simple_splash(
          backgroundColor: Colors.black,
          duration: Duration(seconds: 2),
          logo: Image(image: AssetImage('assets/images/music.jpg')),
          text: 'Welcome to MyApp',
          textSize: 30,
          textColor: Colors.pink,
          //gradient: LinearGradient(colors: [Colors.blue, Colors.purple]),
          whileWaiting: () async {
            // Simulate a task like fetching data
            await Future.delayed(Duration(seconds: 2));
          },
          onFinished: () async {
            // Navigate to the next page
            Navigator.of(context).pushNamed('/home');
          },
        ),
      ),
    );
  }
}
