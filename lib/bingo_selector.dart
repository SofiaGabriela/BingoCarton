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
  selected,
  notSelected,
}

class BingoCarton extends StatefulWidget {
  List<BingoModel> list;
  Color color;
  BingoCarton({Key? key,required this.list, this.color = const Color(0xff0000b2)}) : super(key: key);

  @override
  State<BingoCarton> createState() => _BingoCartonState();
}

class _BingoCartonState extends State<BingoCarton> {

  Options currentOption = Options.selected;
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
      width: 320,
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
            _optionButtons('Elegir mi cartón', Options.selected),
            const SizedBox(width: 15,),
            _optionButtons('Selección aleatoria', Options.notSelected),
        ],),
          const SizedBox(height: 15,),
          _bingoCardList(),
          const SizedBox(height: 10,),
          _counter(),
          const SizedBox(height: 15,),
          const SizedBox(width: 320, height: 20,)
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
              Container(height: 16, width: 16,
                decoration:  BoxDecoration( color: option == currentOption ? widget.color : Colors.white, borderRadius: BorderRadius.circular(100)),),
            ]
          ),
        ),
        const SizedBox(width: 10,),
        Text(text, style: const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.normal, letterSpacing: 0.5))
      ],),);
  }

  Widget _bingoCardList(){
    return SizedBox(
      width: 320,
      height: 280,
      child: RawScrollbar(
        thickness: 5,
        controller: scrollController,
        thumbColor: Colors.blueAccent,
        radius: const Radius.circular(5),
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
        },
      child: Container(
        width: 150,
        height: 33,
        decoration: BoxDecoration(
          border: Border.all(color: widget.color),
          borderRadius: BorderRadius.circular(8),
          color: isSelected ? widget.color : Colors.white ,
        ),
        child: Center(
          child: Text( 'N° ${bingo.number}',
            style: TextStyle(color: isSelected ? Colors.white : widget.color,
                fontWeight: FontWeight.bold, fontSize: 15),),
        ),
      ),
    );
  }

  // width: 320, height: 40
  Widget _counter(){
    return Material(
      elevation: 1,
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(width: 320, height: 40, 
        child: Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Cartones seleccionados', style: TextStyle(color: Colors.grey, fontSize: 14),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('3/3', style: TextStyle(color: widget.color, fontSize: 14, fontWeight: FontWeight.bold),),
          ),
        ],
    ),)
    );
  }
}