
import 'dart:async';
import 'dart:math';

typedef void CardFlipCallback(List<bool> cardFlips);

class Card {
  final String name;
  final String imagePath;
  bool flipped;

  Card(this.name, this.imagePath, this.flipped);
}

class MemoramaGame {
  late List<Card> _cards;
  late List<bool> _cardFlips;
  late int _flippedCardsCount;
  late int _totalPairs;
  late int _matchesFound;
  late bool _gameOver;

  StreamController<List<bool>> _cardsStreamController = StreamController<List<bool>>();
  Stream<List<bool>> get cardsStream => _cardsStreamController.stream;

  CardFlipCallback? onCardFlipsUpdated;

  MemoramaGame(int totalPairs) {
    _totalPairs = totalPairs;
    _matchesFound = 0;
    _gameOver = false;
    _flippedCardsCount = 0;
    _cards = _generateCards(_totalPairs);
    _cardFlips = List.filled(_totalPairs * 2, false);
  }

  List<Card> _generateCards(int totalPairs) {
    List<Card> cards = [];
    for (int i = 0; i < totalPairs; i++) {
      cards.add(Card('$i' + 'a', 'card_${i}a.png', false));
      cards.add(Card('$i' + 'b', 'card_${i}b.png', false));
    }
    cards.shuffle();
    return cards;
  }

  void flipCard(int index) {
    if (!_cardFlips[index] && _flippedCardsCount < 2) {
      _flippedCardsCount++;
      _cardFlips[index] = true;

      if (_flippedCardsCount == 2) {
        _checkMatch();
      }

      _cardsStreamController.sink.add(_cardFlips);

      if (_gameOver) {
        _cardsStreamController.close();
      }
    }
  }

void _checkMatch() {
  print("Check Match called!");
  List<int> flippedIndices = [];
  for (int i = 0; i < _cardFlips.length; i++) {
    if (_cardFlips[i]) {
      flippedIndices.add(i);
    }
  }

  String imagePath1 = _cards[flippedIndices[0] ~/ 2].imagePath;
  String imagePath2 = _cards[flippedIndices[1] ~/ 2].imagePath;

  if (imagePath1 == imagePath2) {
    _matchesFound++;
    if (_matchesFound == _totalPairs) {
      _gameOver = true;
    }
  } else {
    Future.delayed(Duration(seconds: 1), () {
      _unflipCards(flippedIndices);
      onCardFlipsUpdated?.call(_cardFlips);
    });
  }
}



  void _unflipCards(List<int> indices) {
    Timer(Duration(seconds: 1), () {
      for (int index in indices) {
        _cardFlips[index] = false;
      }
      _cardsStreamController.sink.add(_cardFlips);
    });
  }

  List<Card> get cards => _cards;

  bool get gameOver => _gameOver;

  void dispose() {
    _cardsStreamController.close();
  }
}

