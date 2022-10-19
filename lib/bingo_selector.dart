import 'package:flutter/material.dart';

class BingoModel{
  int id;
  int number;

  BingoModel(this.id, this.number);

  int get gedId => id;
  int get getNumber => number;
}

enum Options {
  onSelected,
  notSelected,
}

class BingoCarton extends StatefulWidget {
  const BingoCarton({Key? key}) : super(key: key);

  @override
  State<BingoCarton> createState() => _BingoCartonState();
}

class _BingoCartonState extends State<BingoCarton> {
  // bool selected = true;
  Options currentOption = Options.onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 500,
      color: const Color(0xffF5F5F5),
      child: Column(
        children: [
          const Align( alignment: Alignment.topLeft,
              child: Text('Comprar',
                style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1.0),)),
          const SizedBox(height: 15,),
          const Align( alignment: Alignment.topLeft,
              child: Text('Seleccione una de las siguientes opciones: ',
                style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.normal, letterSpacing: 0.5),)),
          const SizedBox(height: 20,),
          Row( children: [
            _optionButtons('Elegir mi cartón', Options.onSelected),
            const SizedBox(width: 15,),
            _optionButtons('Selección aleatoria', Options.notSelected),
        ],)
        ]
      ),
    );
  }

  Widget _optionButtons(String text, Options option){
    return SizedBox(
      child: Row(children: [
        InkWell(
          onTap: (){
            setState(() {
              currentOption = option;
            });
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(width: 25, height: 25,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.white),),
              Container(height: 18, width: 18,
                decoration:  BoxDecoration( color: option == currentOption ? Colors.blue : Colors.white, borderRadius: BorderRadius.circular(100)),),
            ]
          ),
        ),
        const SizedBox(width: 10,),
        Text(text, style: const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.normal, letterSpacing: 0.5))
      ],),);
  }
}