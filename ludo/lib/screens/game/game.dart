import 'dart:ui';

import 'package:flutter/material.dart';

const kBorderWidth = 0.5;
double size = 24.0;
double get houseSize => size * 6;

applySize(BuildContext context, BoxConstraints consts) {
  size = consts.biggest.width / 15;
  while (size * 15 > MediaQuery.of(context).size.height ||
      size * 15 > MediaQuery.of(context).size.width) {
    size -= 1;
  }
}

get colors => [
      Colors.redAccent,
      Colors.green,
      Colors.blue.shade700,
      Colors.yellow,
    ];

class Game extends StatelessWidget {
  const Game({Key? key}) : super(key: key);

  Widget playerInfo(
    BuildContext context,
    Color color, {
    bool reversed = false,
    String name = 'PLAYER NAME',
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: () {
        final list = [
          Text(
            name,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.all(6.0),
            margin: EdgeInsets.symmetric(horizontal: 0, vertical: 6.0),
            child: Row(children: [
              CircleAvatar(),
            ]),
          ),
        ];
        if (reversed) return list.reversed.toList();
        return list;
      }(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: LayoutBuilder(
            builder: (context, s) {
              applySize(context, s);
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  Column(children: [
                    Row(children: [
                      playerInfo(context, colors[0]),
                      Spacer(),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: playerInfo(context, colors[1]),
                      ),
                    ]),
                    GameBoard(),
                    Row(children: [
                      playerInfo(context, colors[2], reversed: true),
                      Spacer(),
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: playerInfo(context, colors[3], reversed: true),
                      ),
                    ]),
                  ]),
                  Spacer(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class GameBoard extends StatelessWidget {
  const GameBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        color: Colors.white,
        height: size * 15,
        width: size * 15,
        child: Stack(children: [
          Positioned.fill(child: CustomPaint(painter: BoardPainter())),
          // Houses
          Positioned(left: size, top: size, child: BoardHouse()),
          Positioned(right: size, top: size, child: BoardHouse()),
          Positioned(left: size, bottom: size, child: BoardHouse()),
          Positioned(right: size, bottom: size, child: BoardHouse()),
          // Arrows
          Positioned(
            top: houseSize + size,
            height: size,
            width: size,
            child: Icon(Icons.keyboard_arrow_right, color: colors[0]),
          ),
          Positioned(
            left: houseSize + size,
            height: size,
            width: size,
            child: Icon(Icons.keyboard_arrow_down, color: colors[1]),
          ),
          Positioned(
            left: houseSize + size,
            bottom: 0,
            height: size,
            width: size,
            child: Icon(Icons.keyboard_arrow_up, color: colors[2]),
          ),
          Positioned(
            right: 0,
            top: houseSize + size,
            height: size,
            width: size,
            child: Icon(Icons.keyboard_arrow_left, color: colors[3]),
          ),
          // Checkpoints
          Positioned(
            left: size * 2,
            bottom: houseSize,
            height: size,
            width: size,
            child: Icon(
              Icons.star_outline_rounded,
              color: Theme.of(context).focusColor,
            ),
          ),
          Positioned(
            left: houseSize,
            top: size * 2,
            height: size,
            width: size,
            child: Icon(
              Icons.star_outline_rounded,
              color: Theme.of(context).focusColor,
            ),
          ),
          Positioned(
            right: houseSize,
            bottom: size * 2,
            height: size,
            width: size,
            child: Icon(
              Icons.star_outline_rounded,
              color: Theme.of(context).focusColor,
            ),
          ),
          Positioned(
            right: size * 2,
            top: houseSize,
            height: size,
            width: size,
            child: Icon(
              Icons.star_outline_rounded,
              color: Theme.of(context).focusColor,
            ),
          ),
        ]),
      ),
    );
  }
}

class BoardPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size s) {
    final firstPath = Path()
      ..lineTo(houseSize, 0)
      ..lineTo(houseSize, houseSize)
      ..lineTo(size * 2, houseSize)
      ..lineTo(size * 2, houseSize + size)
      ..lineTo(houseSize, houseSize + size)
      ..lineTo(houseSize, houseSize + size * 2)
      ..lineTo(size, houseSize + size * 2)
      ..lineTo(size, houseSize)
      ..lineTo(0, houseSize)
      ..lineTo(0, 0)
      ..moveTo(houseSize, houseSize)
      ..lineTo(houseSize, houseSize + size * 3)
      ..lineTo(houseSize + (size * 3) / 2, houseSize + (size * 3) / 2)
      ..lineTo(houseSize, houseSize)
      ..close();
    canvas.drawPath(firstPath, Paint()..color = colors[0]);
    final secondPath = Path()
      ..moveTo(s.width, 0)
      ..lineTo(houseSize + size * 3, 0)
      ..lineTo(houseSize + size * 3, size)
      ..lineTo(houseSize + size, size)
      ..lineTo(houseSize + size, size * 6)
      ..lineTo(houseSize + size * 2, size * 6)
      ..lineTo(houseSize + size * 2, size * 2)
      ..lineTo(houseSize + size * 3, size * 2)
      ..lineTo(houseSize + size * 3, houseSize)
      ..lineTo(houseSize * 2 + size * 3, houseSize)
      ..lineTo(houseSize * 2 + size * 3, 0)
      ..lineTo(s.width, 0)
      ..moveTo(houseSize, houseSize)
      ..lineTo(houseSize + size * 3, houseSize)
      ..lineTo(houseSize + size + size / 2, houseSize + size + size / 2)
      ..lineTo(houseSize, houseSize)
      ..close();
    canvas.drawPath(secondPath, Paint()..color = colors[1]);
    final thirdPath = Path()
      ..moveTo(0, s.height)
      ..lineTo(0, houseSize + size * 3)
      ..lineTo(houseSize, houseSize + size * 3)
      ..lineTo(houseSize, houseSize * 2 + size)
      ..lineTo(houseSize + size, houseSize * 2 + size)
      ..lineTo(houseSize + size, houseSize + size * 3)
      ..lineTo(houseSize + size * 2, houseSize + size * 3)
      ..lineTo(houseSize + size * 2, houseSize * 2 + size * 2)
      ..lineTo(houseSize, houseSize * 2 + size * 2)
      ..lineTo(houseSize, houseSize * 2 + size * 3)
      ..lineTo(0, houseSize * 2 + size * 3)
      ..moveTo(houseSize, houseSize + size * 3)
      ..lineTo(houseSize + size * 3, houseSize + size * 3)
      ..lineTo(houseSize + size + size / 2, houseSize + size + size / 2)
      ..lineTo(houseSize, houseSize + size * 3)
      ..close();
    canvas.drawPath(thirdPath, Paint()..color = colors[2]);
    final fourthPath = Path()
      ..moveTo(s.width, s.height)
      ..lineTo(houseSize * 2 + size * 3, houseSize + size * 3)
      ..lineTo(houseSize * 2 + size * 2, houseSize + size * 3)
      ..lineTo(houseSize * 2 + size * 2, houseSize + size)
      ..lineTo(houseSize + size * 3, houseSize + size)
      ..lineTo(houseSize + size * 3, houseSize + size * 2)
      ..lineTo(houseSize * 2 + size, houseSize + size * 2)
      ..lineTo(houseSize * 2 + size, houseSize + size * 3)
      ..lineTo(houseSize + size * 3, houseSize + size * 3)
      ..lineTo(houseSize + size * 3, houseSize * 2 + size * 3)
      ..lineTo(houseSize * 2 + size * 3, houseSize * 2 + size * 3)
      ..moveTo(houseSize + size * 3, houseSize)
      ..lineTo(houseSize + size + size / 2, houseSize + size + size / 2)
      ..lineTo(houseSize + size * 3, houseSize + size * 3)
      ..close();
    canvas.drawPath(fourthPath, Paint()..color = colors[3]);

    void drawPoints(Offset from, Offset to) {
      canvas.drawPoints(
        PointMode.lines,
        [from, to],
        Paint()
          ..color = Colors.black
          ..strokeWidth = kBorderWidth,
      );
    }

    drawPoints(
      Offset(houseSize, houseSize),
      Offset(houseSize + size * 3, houseSize + size * 3),
    );

    drawPoints(
      Offset(houseSize + size * 3, houseSize),
      Offset(houseSize, houseSize + size * 3),
    );

    // Draw rows

    for (var i = 1; i < 7; i++) {
      drawPoints(
        Offset(houseSize, size * i),
        Offset(houseSize + size * 3, size * i),
      );
    }

    for (var i = 0; i < 6; i++) {
      drawPoints(
        Offset(houseSize, houseSize + size * 3 + size * i),
        Offset(houseSize + size * 3, houseSize + size * 3 + size * i),
      );
    }

    for (var i = 1; i < 7; i++) {
      drawPoints(
        Offset(size * i, houseSize),
        Offset(size * i, houseSize + size * 3),
      );
    }

    for (var i = 0; i < 6; i++) {
      drawPoints(
        Offset(houseSize + size * 3 + size * i, houseSize),
        Offset(houseSize + size * 3 + size * i, houseSize + size * 3),
      );
    }

    // Draw columns

    for (var i = 0; i < 4; i++) {
      drawPoints(
        Offset(houseSize + size * i, 0),
        Offset(houseSize + size * i, houseSize),
      );
    }

    for (var i = 0; i < 4; i++) {
      drawPoints(
        Offset(houseSize + size * i, houseSize + size * 3),
        Offset(houseSize + size * i, houseSize * 2 + size * 3),
      );
    }

    for (var i = 0; i < 4; i++) {
      drawPoints(
        Offset(0, houseSize + size * i),
        Offset(houseSize, houseSize + size * i),
      );
    }

    for (var i = 0; i < 4; i++) {
      drawPoints(
        Offset(houseSize + size * 3, houseSize + size * i),
        Offset(houseSize * 2 + size * 3, houseSize + size * i),
      );
    }
  }

  @override
  bool shouldRepaint(BoardPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(BoardPainter oldDelegate) => false;
}

class BoardHouse extends StatelessWidget {
  const BoardHouse({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final spot = Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: Colors.black38,
        borderRadius: BorderRadius.circular(12.0),
      ),
    );
    return Container(
      height: size * 4,
      width: size * 4,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [spot, spot],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [spot, spot],
          ),
        ],
      ),
    );
  }
}

class BoardCenter extends StatelessWidget {
  const BoardCenter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      height: size * 3,
      width: size * 3,
      child: Stack(
        children: List.generate(colors.length, (index) {
          final color = colors[index];
          return ClipPath(
            clipper: _TriangleClipper(index),
            child: Container(color: color),
          );
        }),
      ),
    );
  }
}

class _TriangleClipper extends CustomClipper<Path> {
  final int position;

  const _TriangleClipper(this.position);

  @override
  Path getClip(Size size) {
    final path = Path();
    if (position == 0) {
      path.lineTo(size.width / 2, size.height / 2);
      path.lineTo(0, size.height);
      path.lineTo(0, 0);
    } else if (position == 1) {
      path.lineTo(size.width / 2, size.height / 2);
      path.lineTo(size.width, 0);
      path.lineTo(0, 0);
    } else if (position == 2) {
      path.moveTo(0, size.height);
      path.lineTo(size.width / 2, size.height / 2);
      path.lineTo(size.width, size.height);
      path.lineTo(0, size.height);
    } else if (position == 3) {
      path.moveTo(size.width, 0);
      path.lineTo(size.width / 2, size.height / 2);
      path.lineTo(size.width, size.height);
      path.lineTo(size.width, 0);
    }
    return path;
  }

  @override
  bool shouldReclip(_TriangleClipper oldClipper) =>
      position != oldClipper.position;
}
