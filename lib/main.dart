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
          BingoModel(id: 1, number: 100045),
          BingoModel(id: 2, number: 100044),
          BingoModel(id: 4, number: 100043),
          BingoModel(id: 4, number: 100023),
          BingoModel(id: 5, number: 100045),
          BingoModel(id: 5, number: 100044),
          ],
      )
      ),
    );
  }
}