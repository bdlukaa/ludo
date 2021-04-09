import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../game/game.dart';

class NewGame extends StatelessWidget {
  const NewGame({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(padding: EdgeInsets.all(10), children: [
        _NewGameTypeCard(
          icon: FontAwesomeIcons.desktop,
          text: 'vs COMPUTER',
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Game(),
            ));
          },
        ),
        _NewGameTypeCard(
          icon: FontAwesomeIcons.userFriends,
          text: 'vs FRIENDS ',
        ),
        _NewGameTypeCard(
          icon: FontAwesomeIcons.users,
          text: 'vs RANDOM',
        ),
      ]),
    );
  }
}

class _NewGameTypeCard extends StatelessWidget {
  const _NewGameTypeCard({
    Key? key,
    required this.icon,
    required this.text,
    this.onTap,
  }) : super(key: key);

  final IconData icon;
  final String text;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).canvasColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(12.0),
        onTap: onTap ?? () {},
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: IconTheme(
            data: IconThemeData(size: 48),
            child: Row(children: [
              Column(children: [
                Text(
                  text,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                FaIcon(icon)
              ]),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '0 games played',
                      style: TextStyle(color: Colors.blue),
                    ),
                    Text(
                      '0 games won',
                      style: TextStyle(color: Colors.green),
                    ),
                    Text(
                      '0 games lost',
                      style: TextStyle(color: Colors.red),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
