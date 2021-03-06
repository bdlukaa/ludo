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

  int playsInARow = 0;

  @override
  void initState() {
    super.initState();
    turn = math.Random().nextInt(2).clamp(0, 1);
    print('first turn: $turn');
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
    print('turn: $turn cdice: $computerDice pdice: $dice row: $playsInARow');
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Column(children: [
        AnimatedSwitcher(
          duration: kThemeAnimationDuration,
          layoutBuilder: (child, children) => child!,
          transitionBuilder: (child, animation) {
            return ScaleTransition(scale: animation, child: child);
          },
          child: ShaderMask(
            key: ValueKey<int>(turn),
            shaderCallback: (rect) {
              final colors = fightersGradients[isPlayerTurn ? 2 : 1];
              return LinearGradient(
                colors: [
                  colors.shade200,
                  colors.shade300,
                  colors.shade400,
                  colors.shade500,
                  colors.shade600,
                ],
                tileMode: TileMode.mirror,
              ).createShader(rect);
            },
            child: Text(
              isPlayerTurn ? 'YOUR TURN' : 'COMPUTER\'s TURN',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Expanded(
          child: Game(
            thirdHighlight: [
              canMoveFighter(firstPositions[0], dice),
              canMoveFighter(firstPositions[1], dice),
              canMoveFighter(firstPositions[2], dice),
              canMoveFighter(firstPositions[3], dice),
            ],
            secondHighlight: [
              canMoveFighter(secondPositions[0], computerDice),
              canMoveFighter(secondPositions[1], computerDice),
              canMoveFighter(secondPositions[2], computerDice),
              canMoveFighter(secondPositions[3], computerDice),
            ],
            thirdPositions: firstPositions,
            secondPositions: secondPositions,
            onFirstChanged: (v) {},
            onSecondChanged: (v) {},
            onThirdChanged: (v) async {
              if (isPlayerTurn && dice != 0) {
                final position = getDifferentIndex(firstPositions, v);
                for (var i = 0; i < dice; i++) {
                  setState(() => firstPositions[position] += 1);
                  await Future.delayed(
                    figherAnimationDuration + Duration(milliseconds: 15),
                  );
                }
                setState(() {
                  if (dice == 6 && playsInARow < 3) {
                    turn = 0;
                    playsInARow++;
                  } else {
                    turn = 1;
                    playsInARow = 0;
                  }
                  dice = 0;
                });
                computerPlay();
              }
            },
            onFourthChanged: (v) {},
            secondDice: computerDice,
            thirdDice: dice,
            onRollDice: (container) async {
              // Check if it's player turn and make sure the dice is not getting rolled twice
              if (container == 2 && isPlayerTurn && dice == 0) {
                await rollDice((value) => setState(() => dice = value));
                if (!canMoveAnyFighter(firstPositions, dice)) {
                  print('not a valid dice. next turn');
                  setState(() {
                    dice = 0;
                    turn = 1;
                  });
                  computerPlay();
                } else
                  print('dice $dice');
              }
            },
          ),
        ),
      ]),
      bottomNavigationBar: SizedBox(
        height: 48,
        child: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          elevation: 0,
          foregroundColor: Colors.white,
        ),
      ),
    );
  }

  void computerPlay() async {
    if (!isComputerTurn) return;
    print('computer played');
    await rollDice((value) => setState(() => computerDice = value));

    if (canMoveAnyFighter(secondPositions, computerDice)) {
      /// Position math]
      final position =
          secondPositions.indexOf(secondPositions.firstWhere((n) => n < 58));
      computerDice =
          computerDice.clamp(1, 6); // make sure the position is on bounds
      for (var i = 0; i < computerDice; i++) {
        setState(() => secondPositions[position] += 1);
        await Future.delayed(
          figherAnimationDuration + Duration(milliseconds: 15),
        );
      }
      if (dice == 6 && playsInARow < 3) {
        turn = 1;
        playsInARow++;
      } else {
        turn = 0;
        playsInARow = 0;
      }
    } else {
      print('not a valid dice. next turn');
      turn = 0;
    }

    computerDice = 0;
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
    onDice((math.Random().nextInt(6) + 1).clamp(1, 6));
    await Future.delayed(
      Duration(milliseconds: math.Random().nextInt(50) + 250),
    );
  }
  await Future.delayed(Duration(milliseconds: 800));
}

bool canMoveFighter(int position, int dice) {
  if (dice == 0) return false;
  if (position == 0 && dice != 6) return false;
  if (position + dice > 57) return false;
  return true;
}

bool canMoveAnyFighter(List<int> positions, int dice) {
  for (final position in positions) {
    if (canMoveFighter(position, dice)) return true;
  }
  return false;
}
