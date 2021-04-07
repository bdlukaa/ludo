import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        _HomeAppBar(),
        // Friends Card
        Card(
          margin: const EdgeInsets.all(10.0),
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
