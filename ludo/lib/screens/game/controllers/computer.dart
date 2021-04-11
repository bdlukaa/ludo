import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../base.dart';

class ComputerGame extends StatefulWidget {
  ComputerGame({Key? key}) : super(key: key);

  @override
  _ComputerGameState createState() => _ComputerGameState();
}

class _ComputerGameState extends State<ComputerGame> {
  late int turn;

  bool get isPlayerTurn => turn == 0;
  bool get isComputerTurn => turn == 1;

  @override
  void initState() {
    super.initState();
    turn = math.Random().nextInt(1);
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      computerPlay();
    });
  }

  /// The positions of the player
  List<int> firstPositions = [0, 0, 0, 0];

  /// The position of the computer
  List<int> secondPositions = [0, 0, 0, 0];

  int computerDice = 0;
  int dice = 0;

  @override
  Widget build(BuildContext context) {
    print('turn: $turn cdice: $computerDice pdice: $dice');
    return Game(
      thirdPositions: firstPositions,
      secondPositions: secondPositions,
      onFirstChanged: (v) {},
      onSecondChanged: (v) {},
      onThirdChanged: (v) {
        if (isPlayerTurn) {
          setState(() {
            final differentIndex = getDifferentIndex(firstPositions, v);
            firstPositions[differentIndex] += dice;
            dice = 0;
            turn = 1;
          });
          computerPlay();
        }
      },
      onFourthChanged: (v) {},
      secondDice: computerDice,
      thirdDice: dice,
      onRollDice: (container) async {
        if (container == 2 && isPlayerTurn) {
          await rollDice((value) => setState(() => dice = value));
          print('dice $dice');
        }
      },
    );
  }

  void computerPlay() async {
    if (!isComputerTurn) return;
    print('computer played');
    await rollDice((value) => setState(() => computerDice = value));
    secondPositions.first += computerDice;
    if (secondPositions[0] < 58) secondPositions[0] += computerDice;
    else if (secondPositions[1] < 58) secondPositions[1] += computerDice;
    else if (secondPositions[2] < 58) secondPositions[2] += computerDice;
    else if (secondPositions[3] < 58) secondPositions[3] += computerDice;
    computerDice = 0;
    turn = 0;
    setState(() {});
  }
}

int getDifferentIndex(List<int> one, List<int> two) {
  assert(one.length == two.length);
  for (var i = 0; i < one.length; i++) {
    if (one[i] != two[i]) return i;
  }
  return -1;
}

Future<void> rollDice(ValueChanged<int> onDice) async {
  for (var i = 0; i < math.Random().nextInt(8).clamp(5, 8); i++) {
    onDice(math.Random().nextInt(5) + 1);
    await Future.delayed(
      Duration(milliseconds: math.Random().nextInt(50) + 200),
    );
  }
}
