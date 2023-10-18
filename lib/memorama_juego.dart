import 'package:flutter/material.dart';
import 'package:memorama_miniproyecto2/memoramagame.dart';
import 'package:flip_card/flip_card.dart';
import 'package:memorama_miniproyecto2/database_helper.dart';

class MemoramaHomePage extends StatefulWidget {
  final int pairs;

  MemoramaHomePage({required this.pairs});

  @override
  _MemoramaHomePageState createState() => _MemoramaHomePageState();
}

class _MemoramaHomePageState extends State<MemoramaHomePage> {
  late MemoramaGame _game;
  late int _startTime;
  late DatabaseHelper _databaseHelper;

  @override
  void initState() {
    super.initState();
    _game = MemoramaGame(widget.pairs);
    _databaseHelper = DatabaseHelper();
    _startTime = DateTime.now().millisecondsSinceEpoch;

    _game.onCardFlipsUpdated = (List<bool> cardFlips) {
      setState(() {});
    };
  }

  @override
  void dispose() {
    _game.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Memorama App'),
      ),
      body: Center(
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width ~/ 100,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
          ),
          itemCount: widget.pairs * 2,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                if (!_game.cards[index].flipped && !_game.gameOver && _game.cards.where((card) => card.flipped).length < 2) {
                  _game.flipCard(index);
                }
              },
              child: FlipCard(
                direction: FlipDirection.HORIZONTAL,
                flipOnTouch: true,
                front: Container(
                  color: Colors.grey,
                ),
                back: Container(
                  color: Colors.blue,
                  child: Image.asset(
                    'assets/card_${_game.cards[index].name}.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
