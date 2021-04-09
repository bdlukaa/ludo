import 'package:flutter/material.dart';

import '../base.dart';

class ComputerGame extends StatefulWidget {
  ComputerGame({Key? key}) : super(key: key);

  @override
  _ComputerGameState createState() => _ComputerGameState();
}

class _ComputerGameState extends State<ComputerGame> {
  /// The positions of the player
  List<int> firstPositions = [0, 0, 0, 0];

  /// The position of the computer
  List<int> secondPositions = [0, 0, 0, 0];

  @override
  Widget build(BuildContext context) {
    return Game(
      thirdPositions: firstPositions,
      secondPositions: secondPositions,
      onFirstChanged: (v) {},
      onSecondChanged: (v) {},
      onThirdChanged: (v) {},
      onFourthChanged: (v) {},
    );
  }
}
