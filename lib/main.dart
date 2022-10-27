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
      body: Center(
          child: Container(
        width: 370,
        height: 500,
        color: const Color(0xffF5F5F5),
        child: BingoCarton(
          list: [
            BingoModel(
              id: 1,
              number: 100041,
            ),
            BingoModel(id: 2, number: 100042),
            BingoModel(id: 3, number: 100043),
            BingoModel(id: 4, number: 100024),
            BingoModel(id: 5, number: 100045),
            BingoModel(id: 6, number: 100046),
            BingoModel(id: 7, number: 100047),
            BingoModel(id: 8, number: 100048),
            BingoModel(id: 9, number: 100049),
            BingoModel(id: 10, number: 100040),
            BingoModel(id: 11, number: 100021),
            BingoModel(id: 12, number: 100022),
            BingoModel(id: 13, number: 100023),
            BingoModel(id: 14, number: 100029),
          ],
          ShoppIt: (list) {
            print(list);
          },
        ),
      )),
    );
  }
}
