import 'package:bingo_selector/bingo_selector.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: TestMain(),

    );
  }
}

class TestMain extends StatefulWidget {
  const TestMain({Key? key}) : super(key: key);

  @override
  State<TestMain> createState() => _TestMainState();
}

class _TestMainState extends State<TestMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.white,),
      body: Center(child: BingoCarton(
        list: [
          BingoModel(1,  '10000'),
          BingoModel(2,  '10002'),
          BingoModel(3,  '10003'),
          BingoModel(4,  '10004'),
          BingoModel(5,  '10005'),
          BingoModel(6,  '10006'),
          BingoModel(6,  '10006'),
          BingoModel(6,  '10006'),
          BingoModel(6,  '10006'),
          BingoModel(6,  '10006'),
          BingoModel(6,  '10006'),
          BingoModel(6,  '10006'),
          BingoModel(6,  '10006'),
          BingoModel(6,  '10006'),
          BingoModel(6,  '10006'),
          BingoModel(7, '123456')],
      )),

    );
  }
}