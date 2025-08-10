import 'package:calculator_/home_screen.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override 
  Widget build(BuildContext contex){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      home: HomeScreen(),
    );
  }
}