import 'package:flutter/material.dart';

class BingoModel{
  int id;
  int number;
  bool? itsPressed;

  BingoModel({required this.id, required this.number,this.itsPressed = false});

  int get gedId => id;
  int get getNumber => number;
}

enum Options {
  onSelected,
  notSelected,
}

class BingoCarton extends StatefulWidget {
  List<BingoModel> list;
  Color? color;
  BingoCarton({Key? key,required this.list, this.color = Colors.blue}) : super(key: key);


  @override
  State<BingoCarton> createState() => _BingoCartonState();
}

class _BingoCartonState extends State<BingoCarton> {

  Options currentOption = Options.onSelected;
  List<Widget> bingoCards = [];
  List<int> selectedBingos = [];
  ScrollController scrollController = ScrollController();

  void addBingo(BingoModel bingo){
    setState(() {
      selectedBingos.add(bingo.id);
    });
  }

  @override
  void initState() {
    widget.list.forEach((element) {
      bingoCards.add(_bingoButton(element));
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
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
          const SizedBox(height: 15,),
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

  _bingoCardList(){
    return Container(
      width: 350,
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
              //thickness: MaterialStatePropertyAll(4),
              //thumbVisibility: MaterialStatePropertyAll(false),
            ),
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Wrap(
              direction: Axis.horizontal,
              spacing: 15,
              runSpacing: 15,
              children: bingoCards,
            ),
          ),
        ),
      ),
    );
  }

  Widget _bingoButton(BingoModel bingo){
    bool isSelected = false;

    return InkWell(
      onTap: (){
        addBingo(bingo);
        isSelected = selectedBingos.contains(bingo.id);
        print(isSelected);
        print(selectedBingos);},
      child: Container(
        width: 150,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isSelected ? widget.color : Colors.white ,
        ),
        child: Center(
          child: Text( 'N° ' + bingo.number.toString(),
            style: TextStyle(color: isSelected ? Colors.white : widget.color,
                fontWeight: FontWeight.bold, fontSize: 15),),
        ),
      ),
    );
  }
}