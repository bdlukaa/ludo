import 'package:flutter/material.dart';

import 'new_game/history.dart';
import 'new_game/new_game.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        _HomeAppBar(),
        // Friends Card
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(children: [
                    Text(
                      'FRIENDS',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 2.0),
                      padding: EdgeInsets.all(5.5),
                      decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '0',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                    Spacer(),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.add),
                      label: Text('Add'),
                    ),
                  ]),
                ),
                // TODO: check friends amount
                if (true)
                  Container(
                    margin: EdgeInsets.only(top: 6.0),
                    height: 42.0,
                    child: ShaderMask(
                      shaderCallback: (rect) {
                        return LinearGradient(
                          colors: [
                            Colors.black,
                            Colors.transparent,
                          ],
                          begin: Alignment(0.9, 0.0),
                        ).createShader(rect);
                      },
                      child: ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        children: List.generate(10, (index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 4.0),
                            child: CircleAvatar(),
                          );
                        }),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        // Games card
        Expanded(
          child: Card(
            margin: EdgeInsets.only(top: 10.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(12.0)),
            ),
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: DefaultTabController(
                length: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TabBar(tabs: [
                      Tab(text: 'NEW GAME'),
                      Tab(text: 'GAME HISTORY'),
                    ]),
                    Expanded(
                      child: TabBarView(children: [
                        NewGame(),
                        Builder(
                          builder: (context) => GameHistory(
                            onNewGame: () {
                              final controller =
                                  DefaultTabController.of(context);
                              controller!.animateTo(0);
                            },
                          ),
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

class _HomeAppBar extends StatelessWidget {
  const _HomeAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      child: Container(
        height: 44.0,
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.center,
        child: Row(children: [
          // IconButton(
          //   icon: Icon(Icons.),
          // ),
          Expanded(
            child: Text(
              'LUDO',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          CircleAvatar(),
        ]),
      ),
    );
  }
}
