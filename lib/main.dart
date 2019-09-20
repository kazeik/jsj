import 'package:flutter/material.dart';
import 'package:jsj/page/HomePage.dart';
import 'package:jsj/page/LoginPage.dart';
import 'package:jsj/page/MainPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    HttpNet.instance.set(context);
    return MaterialApp(
        title: 'jsj钱包',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: LoginPage(),
        routes: {
          '/loginPage': (context) => LoginPage(),
          '/home': (context) => HomePage(),
          '/main': (context) => MainPage()}
        );
  }
}
