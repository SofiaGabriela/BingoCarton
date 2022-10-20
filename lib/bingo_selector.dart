import 'package:bingo_selector/custom_buton.dart';
import 'package:flutter/material.dart';

class BingoModel{
  int id;
  String number;

  BingoModel(this.id, this.number);


}

enum Options {
  onSelected,
  notSelected,
}

class BingoCarton extends StatefulWidget {
  List<BingoModel> list;
  BingoCarton({Key? key,required this.list }) : super(key: key);

  @override
  State<BingoCarton> createState() => _BingoCartonState();
}

class _BingoCartonState extends State<BingoCarton> {
  // bool selected = true;
  Options currentOption = Options.onSelected;
  List<Widget> bingoCards = [];
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    widget.list.forEach((element) {
      bingoCards.add(_bingoCard(element));
    });
    super.initState();
  }

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
        ],),
          SizedBox(height: 40,),
          _bingoCardList()
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
  
  _bingoCard(BingoModel element){
    return CustomButton(
      text: element.number,
      borderColor: Colors.blueAccent,
      backgroundColor: Colors.white,
      textColor: Colors.blueAccent,
      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 40),
      textStyle: TextStyle(fontSize: 16),
    );
  }

  _bingoCardList(){
    return Container(
      height: 300,
      color: Colors.greenAccent,
      child: RawScrollbar(
        thickness: 5,
        controller: scrollController,
        thumbColor: Colors.blueAccent,
        radius: Radius.circular(5),
        child: Theme(
          data:ThemeData(
                scrollbarTheme: const ScrollbarThemeData(
                        thickness: MaterialStatePropertyAll(4),
                        thumbVisibility: MaterialStatePropertyAll(false),
                ),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Wrap(
              direction: Axis.horizontal,
              spacing: 40,
              runSpacing: 20,
              children: bingoCards,
            ),
          ),
        ),
      ),
    );
  }
}