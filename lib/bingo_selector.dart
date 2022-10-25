import 'dart:math';
import 'package:flutter/material.dart';

class BingoModel{
  int id;
  int number;

  BingoModel({required this.id, required this.number});

  int get gedId => id;
  int get getNumber => number;
}

enum Options {
  manual,
  random,
}

class BingoCarton extends StatefulWidget {
  int maxAmount;
  List<BingoModel> list;
  Color color;
  Function(List<int>)? onBuy;

  BingoCarton({
    Key? key,
    required this.list,
    this.color = const Color(0xff0000b2),
    this.onBuy,
    this.maxAmount = 3,
  }) : super(key: key);

  @override
  State<BingoCarton> createState() => _BingoCartonState();
}

class _BingoCartonState extends State<BingoCarton> {
  Options currentOption = Options.manual;
  List<Widget> bingoCards = [];
  List<BingoModel> randomBingoCards = [];
  List<int> selectedBingos = [];
  ScrollController scrollController = ScrollController();

  void addBingo(BingoModel bingo){
    setState(() {
      if (selectedBingos.contains(bingo.id)) {
        selectedBingos.remove(bingo.id);
      } else if (selectedBingos.length < widget.maxAmount) { selectedBingos.add(bingo.id); }
    });
  }

  void onChangeOption(Options option) {
    setState(() {
      selectedBingos = [];
      currentOption = option;
      if (option == Options.random){
        randomBingoCards = [];
        randomBingoCards = getRandomList();
        randomBingoCards.forEach((element) {addBingo(element);});
      }
    });
  }

  List<BingoModel> getRandomList( ){
    final random = Random();
    List<BingoModel> list = [];
    int aux = 0;
    int cantidad = widget.maxAmount;
    int tope = widget.list.length;
    for(int i=0; i< cantidad; i++ ){
      aux = random.nextInt(tope);
      while(list.contains(widget.list[aux])){
        aux = random.nextInt(tope);
      }
      list.add(widget.list[aux]);
    }
    return list;

  }

  @override
  Widget build(BuildContext context) {
    bingoCards = [];
    (currentOption == Options.manual? widget.list : randomBingoCards).forEach((element) {
      bingoCards.add(_bingoButton(element));
    });

    return Container(
      width: 320,
      height: 500,
      color: const Color(0xffF5F5F5),
      child: Column(
        children: [
          _text(),
          const SizedBox(height: 20,),
          SizedBox(
            width: 320,
            child: Row( children: [
              _optionButtons('Elegir mi cartón', Options.manual),
              const SizedBox(width: 15,),
              _optionButtons('Selección aleatoria', Options.random),
        ],),
          ),
          _pagesControl()
        ]
      ),
    );
  }

  _text(){
    return
      Column(
      children : const [
        SizedBox(
        width: 320, height: 35,
        child: Align( alignment: Alignment.topLeft,
            child: Text('Comprar',
              style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1.0),)),
      ),
       SizedBox(
        width: 320,
        child: Align( alignment: Alignment.topLeft,
            child: Text('Seleccione una de las siguientes opciones: ',
              style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.normal, letterSpacing: 0.5),)),
      ),
        ]
      );
  }

  Widget _optionButtons(String text, Options option){
    return SizedBox(
      child: Row(children: [
        InkWell(
          onTap: (){ onChangeOption(option); },
          child: Stack(
            alignment: Alignment.center,
            children: [
              Material(
                elevation: 3,
                borderRadius: BorderRadius.circular(100),
                child: Container(width: 25, height: 25,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: Colors.white),),
              ),
              Container(height: 16, width: 16,
                decoration:  BoxDecoration( color: option == currentOption ? widget.color : Colors.white, borderRadius: BorderRadius.circular(100)),),
            ]
          ),
        ),
        const SizedBox(width: 10,),
        Text(text, style: const TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.normal, letterSpacing: 0.5))
      ],),);
  }

  Widget _pagesControl(){
    return IndexedStack(
      index: currentOption.index,
      children: [
        _manualOptionPage(),
        _randomOptionPage()
      ],
    );
  }

  Widget _manualOptionPage(){
    return SizedBox( child: Column( children: [
        const SizedBox(height: 15,),
        _bingoCardList(),
        const SizedBox(height: 10,),
        _counter(),
        const SizedBox(height: 15,),
        CustomButton(text: 'Pagar',backgroundColor: widget.color, textSize: 13, isEnabled: selectedBingos.isNotEmpty,
        onTap: (){ widget.onBuy!(selectedBingos);  } ,)],
      ),
      );
}

  Widget _randomOptionPage(){
    return Column( children: [
      const SizedBox(height: 15,),
      Wrap(
      direction: Axis.horizontal,
      spacing: 15,
      runSpacing: 15,
      children: bingoCards,),
      const SizedBox(height: 15,),
      CustomButton(text: 'Pagar',backgroundColor: widget.color, textSize: 13, isEnabled: selectedBingos.isNotEmpty,
          onTap: (){ widget.onBuy!(selectedBingos);  } )
    ],
    );
  }

  Widget _bingoCardList(){
    return SizedBox(
      width: 320,
      height: 280,
      child: RawScrollbar(
        thumbVisibility: false,
        thickness: 5,
        controller: scrollController,
        thumbColor: Colors.transparent,
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
    bool isSelected = selectedBingos.contains(bingo.id);

    return InkWell(
      onTap: (){
        addBingo(bingo);
        },
      child: AnimatedContainer(
        duration: const Duration (milliseconds: 200),
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
            child: Text( '${selectedBingos.length.toString()} / ${widget.maxAmount}', style: TextStyle(color: widget.color, fontSize: 14, fontWeight: FontWeight.bold),),
          ),
        ],
    ),)
    );
  }
}


class CustomButton extends StatefulWidget {
  final String text;
  final double height;
  final double width;
  final Color backgroundColor;
  final Color textColor;
  final Color iconColor;
  final double? textSize;
  final double? iconSize;
  final FontWeight textWeight;
  bool isEnabled;
  Function? onTap;
  final IconData? icon;
  final String? iconPath;
  final Color borderColor;
  final double borderWidth;

  CustomButton({
    super.key,
    required this.text,
    this.height = 30,
    this.width = 250,
    this.backgroundColor = const Color(0xff0000b2),
    this.textColor = Colors.white,
    this.borderColor = Colors.transparent,
    this.borderWidth = 1,
    this.isEnabled = false,
    this.onTap,
    this.icon,
    this.textWeight = FontWeight.normal,
    this.iconPath,
    this.iconColor = Colors.white,
    this.textSize,
    this.iconSize,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      decoration: BoxDecoration(
        border: Border.all(
          width: widget.borderWidth,
          color: widget.borderColor,
        ),
        borderRadius: BorderRadius.circular(widget.height / 2),
        color: widget.isEnabled ? widget.backgroundColor : Colors.grey,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          hoverColor:
          widget.isEnabled ? widget.backgroundColor : Colors.transparent,
          splashFactory: widget.isEnabled
              ? InkSplash.splashFactory
              : NoSplash.splashFactory,
          borderRadius: BorderRadius.circular(widget.height / 2),
          onTap: () {_onTap();},
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _icon(),
                _text(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTap() {
    widget.isEnabled ? widget.onTap!() : null;
  }

  Widget _icon() {
    if (widget.iconPath != null) {
      return Padding(
        padding: const EdgeInsets.only(right: 5),
        child: Image.asset(
          widget.iconPath!,
          height: widget.iconSize ?? (widget.height / 2),
          width: widget.iconSize ?? (widget.height / 2),
          fit: BoxFit.cover,
          color: widget.iconColor,
        ),
      );
    }

    if (widget.icon != null && widget.iconPath == null) {
      return Padding(
        padding: const EdgeInsets.only(right: 5),
        child: Icon(
          widget.icon,
          color: widget.iconColor,
          size: widget.iconSize ?? (widget.height / 2),
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _text() {
    return Text(
      widget.text,
      style: TextStyle(
        fontWeight: widget.textWeight,
        color: widget.textColor,
        fontSize: widget.textSize ?? (widget.height / 2),
        letterSpacing: 0,
      ),
    );
  }
}
