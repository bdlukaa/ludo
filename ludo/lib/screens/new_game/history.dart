import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GameHistory extends StatelessWidget {
  const GameHistory({Key? key, this.onNewGame}) : super(key: key);

  final VoidCallback? onNewGame;

  @override
  Widget build(BuildContext context) {
    final int amount = 0;
    if (amount == 0) {
      return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          'You haven\'t played yet!',
          style: Theme.of(context).textTheme.subtitle1,
        ),
        SizedBox(height: 8.0),
        ElevatedButton.icon(
          onPressed: onNewGame,
          icon: Icon(FontAwesomeIcons.gamepad),
          label: Text('NEW GAME'),
        ),
      ]);
    }
    return Container();
  }
}
