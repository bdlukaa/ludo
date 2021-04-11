import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../utils/extensions.dart';

// TODO: animate fighters when moving. Step by step

const kBorderWidth = 0.5;
double size = 24.0;
double get houseSize => size * 6;

const fighterIcon = FontAwesomeIcons.chessPawn;

List<Offset> get blankPositions => <Offset>[
      Offset(houseSize, 0),
      Offset(houseSize + size, 0),
      Offset(houseSize + size * 2, 0),
      Offset(houseSize + size * 2, size * 1),
      Offset(houseSize + size * 2, size * 2),
      Offset(houseSize + size * 2, size * 3),
      Offset(houseSize + size * 2, size * 4),
      Offset(houseSize + size * 2, size * 5),
      Offset(houseSize + size * 3, size * 6),
      Offset(houseSize + size * 4, size * 6),
      Offset(houseSize + size * 5, size * 6),
      Offset(houseSize + size * 6, size * 6),
      Offset(houseSize + size * 7, size * 6),
      Offset(houseSize + size * 8, size * 6),
      Offset(houseSize + size * 8, size * 7),
      Offset(houseSize + size * 8, size * 8),
      Offset(houseSize + size * 7, size * 8),
      Offset(houseSize + size * 6, size * 8),
      Offset(houseSize + size * 5, size * 8),
      Offset(houseSize + size * 4, size * 8),
      Offset(houseSize + size * 3, size * 8),
      Offset(houseSize + size * 2, size * 9),
      Offset(houseSize + size * 2, size * 10),
      Offset(houseSize + size * 2, size * 11),
      Offset(houseSize + size * 2, size * 12),
      Offset(houseSize + size * 2, size * 13),
      Offset(houseSize + size * 2, size * 14),
      Offset(houseSize + size * 1, size * 14),
      Offset(houseSize, size * 14),
      Offset(houseSize, size * 13),
      Offset(houseSize, size * 13),
      Offset(houseSize, size * 12),
      Offset(houseSize, size * 11),
      Offset(houseSize, size * 10),
      Offset(houseSize, size * 9),
      Offset(size * 5, size * 8),
      Offset(size * 4, size * 8),
      Offset(size * 3, size * 8),
      Offset(size * 2, size * 8),
      Offset(size * 1, size * 8),
      Offset(size * 0, size * 8),
      Offset(size * 0, size * 7),
      Offset(size * 0, size * 6),
      Offset(size * 1, size * 6),
      Offset(size * 2, size * 6),
      Offset(size * 3, size * 6),
      Offset(size * 4, size * 6),
      Offset(size * 5, size * 6),
      Offset(size * 6, size * 5),
      Offset(size * 6, size * 4),
      Offset(size * 6, size * 3),
      Offset(size * 6, size * 2),
      Offset(size * 6, size * 1),
    ];

const firstIndex = 43;
const secondIndex = 3;
const thirdIndex = 29;
const fourthIndex = 16;

void applySize(BuildContext context, BoxConstraints consts) {
  size = consts.biggest.width / 15;
  while (size * 15 > MediaQuery.of(context).size.height ||
      size * 15 > MediaQuery.of(context).size.width) {
    size -= 1;
  }
}

List<Color> get colors => [
      Colors.redAccent,
      Colors.green,
      Colors.blue.shade700,
      Colors.yellow,
    ];

List<Color> get fighterColors => [
      Colors.red.shade700,
      Colors.green.shade700,
      Colors.blue,
      Colors.amber.shade600,
    ];

class Game extends StatelessWidget {
  const Game({
    Key? key,
    this.firstPositions,
    this.secondPositions = const [0, 0, 0, 0],
    this.thirdPositions = const [0, 0, 0, 0],
    this.fourthPositions,
    required this.onFirstChanged,
    required this.onSecondChanged,
    required this.onThirdChanged,
    required this.onFourthChanged,
    this.firstDice = 0,
    this.secondDice = 0,
    this.thirdDice = 0,
    this.fourthDice = 0,
    required this.onRollDice,
  }) : super(key: key);

  final List<int>? firstPositions;
  final List<int> secondPositions;
  final List<int> thirdPositions;
  final List<int>? fourthPositions;

  final ValueChanged<List<int>> onFirstChanged;
  final ValueChanged<List<int>> onSecondChanged;
  final ValueChanged<List<int>> onThirdChanged;
  final ValueChanged<List<int>> onFourthChanged;

  final int firstDice;
  final int secondDice;
  final int thirdDice;
  final int fourthDice;

  final ValueChanged<int> onRollDice;

  Widget playerInfo(
    BuildContext context,
    Color color, {
    bool reversed = false,
    String name = 'PLAYER NAME',
    int dice = 0,
    VoidCallback? onRollDice,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: () {
        final list = [
          Text(
            name,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          Row(children: [
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
            Container(
              height: 35,
              // width: 45,
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6.0),
                child: InkWell(
                  borderRadius: BorderRadius.circular(6.0),
                  onTap: onRollDice,
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: AnimatedSwitcher(
                      duration: Duration(milliseconds: 160),
                      transitionBuilder: (child, animation) {
                        return ScaleTransition(scale: animation, child: child);
                      },
                      child: FaIcon(
                        () {
                          switch (dice) {
                            case 0:
                              return FontAwesomeIcons.dice;
                            case 1:
                              return FontAwesomeIcons.diceOne;
                            case 2:
                              return FontAwesomeIcons.diceTwo;
                            case 3:
                              return FontAwesomeIcons.diceThree;
                            case 4:
                              return FontAwesomeIcons.diceFour;
                            case 5:
                              return FontAwesomeIcons.diceFive;
                            case 6:
                              return FontAwesomeIcons.diceSix;
                          }
                        }(),
                        color: Colors.grey[120],
                        key: ValueKey<int>(dice),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ]),
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
          child: LayoutBuilder(builder: (context, s) {
            applySize(context, s);
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Column(children: [
                  Row(children: [
                    if (firstPositions != null)
                      playerInfo(
                        context,
                        colors[0],
                        onRollDice: () => onRollDice(0),
                        dice: firstDice,
                      ),
                    Spacer(),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: playerInfo(
                        context,
                        colors[1],
                        onRollDice: () => onRollDice(1),
                        dice: secondDice,
                      ),
                    ),
                  ]),
                  GameBoard(
                    firstPositions: firstPositions ?? [100, 100, 100, 100],
                    secondPositions: secondPositions,
                    thirdPositions: thirdPositions,
                    fourthPositions: fourthPositions ?? [100, 100, 100, 100],
                    onFighterTapped: (container, number, index) {
                      print(
                          'tapped fighter $index in container $container at position $number');
                      if (container == 2) {
                        if (number == 58) return;
                        onThirdChanged(
                          thirdPositions.toList()..[index] = number + 1,
                        );
                      }
                    },
                  ),
                  Row(children: [
                    playerInfo(
                      context,
                      colors[2],
                      reversed: true,
                      onRollDice: () => onRollDice(2),
                      dice: thirdDice,
                    ),
                    Spacer(),
                    if (fourthPositions != null)
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: playerInfo(
                          context,
                          colors[3],
                          reversed: true,
                          onRollDice: () => onRollDice(3),
                          dice: fourthDice,
                        ),
                      ),
                  ]),
                ]),
                Spacer(),
              ],
            );
          }),
        ),
      ),
    );
  }
}

class GameBoard extends StatelessWidget {
  const GameBoard({
    Key? key,
    required this.firstPositions,
    required this.secondPositions,
    required this.thirdPositions,
    required this.fourthPositions,
    required this.onFighterTapped,
  }) : super(key: key);

  final List<int> firstPositions;
  final List<int> secondPositions;
  final List<int> thirdPositions;
  final List<int> fourthPositions;

  final void Function(int container, int number, int index) onFighterTapped;

  List<Offset> calculatePosition(List<int> positions, int container) {
    Offset? first;
    Offset? second;
    Offset? third;
    Offset? fourth;

    Offset blankPosition(int position, index) {
      return blankPositions.startAt(index)[position - 1];
    }

    switch (container) {
      case 0:
        // Initial positions
        if (positions[0] == 0) {
          first = Offset(size + size / 1.5, size * 1.4);
        }
        if (positions[1] == 0) {
          second = Offset(size * 3.32, size * 1.4);
        }
        if (positions[2] == 0) {
          third = Offset(size + size / 1.5, size * 3);
        }
        if (positions[3] == 0) {
          fourth = Offset(size * 3.32, size * 3);
        }

        if (positions[0] < 52)
          first ??= blankPosition(firstIndex, positions[0]);
        if (positions[1] < 52)
          second ??= blankPosition(firstIndex, positions[1]);
        if (positions[2] < 52)
          third ??= blankPosition(firstIndex, positions[2]);
        if (positions[3] < 52)
          fourth ??= blankPosition(firstIndex, positions[3]);

        if (positions[0] <= 58)
          first ??= Offset(size * (positions[0] - 52), houseSize + size);
        if (positions[1] <= 58)
          second ??= Offset(size * (positions[0] - 52), houseSize + size);
        if (positions[2] <= 58)
          third ??= Offset(size * (positions[0] - 52), houseSize + size);
        if (positions[3] <= 58)
          fourth ??= Offset(size * (positions[0] - 52), houseSize + size);
        break;
      case 1:
        // Initial positions
        final factor = houseSize + size * 3;
        if (positions[0] == 0) {
          first = Offset(factor + size + size / 1.5, size * 1.4);
        }
        if (positions[1] == 0) {
          second = Offset(factor + size * 3.32, size * 1.4);
        }
        if (positions[2] == 0) {
          third = Offset(factor + size + size / 1.5, size * 3);
        }
        if (positions[3] == 0) {
          fourth = Offset(factor + size * 3.32, size * 3);
        }

        if (positions[0] < 52)
          first ??= blankPosition(secondIndex, positions[0]);
        if (positions[1] < 52)
          second ??= blankPosition(secondIndex, positions[1]);
        if (positions[2] < 52)
          third ??= blankPosition(secondIndex, positions[2]);
        if (positions[3] < 52)
          fourth ??= blankPosition(secondIndex, positions[3]);

        if (positions[0] <= 58)
          first ??= Offset(houseSize + size, size * (positions[0] - 52));
        if (positions[1] <= 58)
          second ??= Offset(houseSize + size, size * (positions[1] - 52));
        if (positions[2] <= 58)
          third ??= Offset(houseSize + size, size * (positions[2] - 52));
        if (positions[3] <= 58)
          fourth ??= Offset(houseSize + size, size * (positions[3] - 52));
        break;
      case 2:
        // Initial positions
        final factor = houseSize + size * 3;
        if (positions[0] == 0) {
          first = Offset(size + size / 1.5, factor + size * 1.4);
        }
        if (positions[1] == 0) {
          second = Offset(size * 3.32, factor + size * 1.4);
        }
        if (positions[2] == 0) {
          third = Offset(size + size / 1.5, factor + size * 3);
        }
        if (positions[3] == 0) {
          fourth = Offset(size * 3.32, factor + size * 3);
        }

        if (positions[0] < 52)
          first ??= blankPosition(thirdIndex, positions[0]);
        if (positions[1] < 52)
          second ??= blankPosition(thirdIndex, positions[1]);
        if (positions[2] < 52)
          third ??= blankPosition(thirdIndex, positions[2]);
        if (positions[3] < 52)
          fourth ??= blankPosition(thirdIndex, positions[3]);

        if (positions[0] <= 58)
          first ??= Offset(
            houseSize + size,
            factor + houseSize - size - size * (positions[0] - 52),
          );
        if (positions[1] <= 58)
          second ??= Offset(
            houseSize + size,
            factor + houseSize - size - size * (positions[1] - 52),
          );
        if (positions[2] <= 58)
          third ??= Offset(
            houseSize + size,
            factor + houseSize - size - size * (positions[2] - 52),
          );
        if (positions[3] <= 58)
          fourth ??= Offset(
            houseSize + size,
            factor + houseSize - size - size * (positions[3] - 52),
          );
        break;
      case 3:
        // Initial positions
        final factor = houseSize + size * 3;
        if (positions[0] == 0) {
          first = Offset(factor + size + size / 1.5, factor + size * 1.4);
        }
        if (positions[1] == 0) {
          second = Offset(factor + size * 3.32, factor + size * 1.4);
        }
        if (positions[2] == 0) {
          third = Offset(factor + size + size / 1.5, factor + size * 3);
        }
        if (positions[3] == 0) {
          fourth = Offset(factor + size * 3.32, factor + size * 3);
        }

        if (positions[0] < 52)
          first ??= blankPosition(fourthIndex, positions[0]);
        if (positions[1] < 52)
          second ??= blankPosition(fourthIndex, positions[1]);
        if (positions[2] < 52)
          third ??= blankPosition(fourthIndex, positions[2]);
        if (positions[3] < 52)
          fourth ??= blankPosition(fourthIndex, positions[3]);

        if (positions[0] <= 58)
          first ??= Offset(
            factor + houseSize - size - size * (positions[0] - 52),
            factor + houseSize,
          );
        if (positions[1] <= 58)
          second ??= Offset(
            factor + houseSize - size - size * (positions[1] - 52),
            factor + houseSize,
          );
        if (positions[2] <= 58)
          third ??= Offset(
            factor + houseSize - size - size * (positions[2] - 52),
            factor + houseSize,
          );
        if (positions[3] <= 58)
          fourth ??= Offset(
            factor + houseSize - size - size * (positions[3] - 52),
            houseSize + size,
          );
        break;
    }
    first ??= Offset(-size, -size);
    second ??= Offset(-size, -size);
    third ??= Offset(-size, -size);
    fourth ??= Offset(-size, -size);
    return [first, second, third, fourth];
  }

  List<List<int>> get positions => [
        firstPositions,
        secondPositions,
        thirdPositions,
        fourthPositions,
      ];

  @override
  Widget build(BuildContext context) {
    final showNumbers = kDebugMode;
    final showFighterHitbox = false;
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
          // Numbers
          if (showNumbers)
            ...List.generate(blankPositions.length, (index) {
              final offset = blankPositions[index];
              return Positioned(
                left: offset.dx,
                top: offset.dy,
                child: Text(
                  '$index',
                  style: Theme.of(context).textTheme.overline,
                ),
              );
            }),
          // Fighters
          ...List<Widget>.generate(positions.length, (container) {
            final offsets = calculatePosition(positions[container], container);
            return Positioned.fill(
              child: Stack(children: [
                ...List<Widget>.generate(4, (index) {
                  final offset = offsets[index];
                  return Positioned(
                    left: offset.dx,
                    top: offset.dy,
                    height: size,
                    width: size,
                    child: GestureDetector(
                      key: ValueKey<String>('#$container$index'),
                      onTap: () {
                        _handleFighterTapped(container, index);
                      },
                      child: Container(
                        color: showFighterHitbox
                            ? Colors.black26
                            : Colors.transparent,
                        child: Icon(
                          fighterIcon,
                          color: fighterColors[container],
                        ),
                      ),
                    ),
                  );
                })
              ]),
            );
          }),
        ]),
      ),
    );
  }

  void _handleFighterTapped(int container, int number) {
    final position = positions[container][number];
    // final offset = calculatePosition(positions[container], container)[number];
    onFighterTapped(container, position, number);
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
        color: Colors.black12,
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
