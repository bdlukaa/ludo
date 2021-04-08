import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:auth_buttons/auth_buttons.dart';

const _ludoSpans = [
  TextSpan(text: 'L', style: TextStyle(color: Colors.red)),
  TextSpan(text: 'U', style: TextStyle(color: Colors.green)),
  TextSpan(text: 'D', style: TextStyle(color: Colors.blueAccent)),
  TextSpan(text: 'O', style: TextStyle(color: Colors.yellow)),
];

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Container(
        // Use this instead of `SafeArea`
        margin: MediaQuery.of(context).viewPadding,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: _ludoSpans,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: 'Sign in to play ',
                    children: [
                      ..._ludoSpans,
                      TextSpan(text: ' with your friends')
                    ],
                  ),
                ),
              ],
            ),
          ),
          Spacer(flex: 2),
          Expanded(
            child: Column(children: [
              Container(
                height: 40,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.lightBlue,
                      Colors.blue,
                    ],
                  ),
                ),
              ),
              Expanded(
                child: CustomPaint(
                  painter: _LudoBackgroundPainter(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 36.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GoogleAuthButton(
                          onPressed: () {},
                          iconStyle: AuthIconStyle.outlined,
                          style: AuthButtonStyle.icon,
                        ),
                        SizedBox(width: 6.0),
                        FacebookAuthButton(
                          onPressed: () {},
                          iconStyle: AuthIconStyle.outlined,
                          style: AuthButtonStyle.icon,
                        ),
                        if (kDebugMode ||
                            [
                              TargetPlatform.iOS,
                              TargetPlatform.macOS,
                            ].contains(defaultTargetPlatform)) ...[
                          SizedBox(width: 6.0),
                          AppleAuthButton(
                            onPressed: () {},
                            iconStyle: AuthIconStyle.outlined,
                            style: AuthButtonStyle.icon,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}

class _LudoBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPath(
      Path()
        ..lineTo(size.width, 0)
        ..lineTo(size.width, size.height)
        ..lineTo(0, size.height)
        ..lineTo(0, 0),
      Paint()..color = Colors.yellow,
    );
    Path path = Path();
    path.lineTo(0, size.height * 0.75);
    path.quadraticBezierTo(size.width * 0.10, size.height * 0.70,
        size.width * 0.17, size.height * 0.90);
    path.quadraticBezierTo(
        size.width * 0.20, size.height, size.width * 0.25, size.height * 0.90);
    path.quadraticBezierTo(size.width * 0.40, size.height * 0.40,
        size.width * 0.50, size.height * 0.70);
    path.quadraticBezierTo(size.width * 0.60, size.height * 0.85,
        size.width * 0.65, size.height * 0.65);
    path.quadraticBezierTo(
        size.width * 0.70, size.height * 0.90, size.width, 0);
    path.close();

    canvas.drawPath(path, Paint()..color = Colors.red);

    path = Path();
    path.lineTo(0, size.height * 0.50);
    path.quadraticBezierTo(size.width * 0.10, size.height * 0.80,
        size.width * 0.15, size.height * 0.60);
    path.quadraticBezierTo(size.width * 0.20, size.height * 0.45,
        size.width * 0.27, size.height * 0.60);
    path.quadraticBezierTo(
        size.width * 0.45, size.height, size.width * 0.50, size.height * 0.80);
    path.quadraticBezierTo(size.width * 0.55, size.height * 0.45,
        size.width * 0.75, size.height * 0.75);
    path.quadraticBezierTo(
        size.width * 0.85, size.height * 0.93, size.width, size.height * 0.60);
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, Paint()..color = Colors.green);

    path = Path();
    path.lineTo(0, size.height * 0.75);
    path.quadraticBezierTo(size.width * 0.10, size.height * 0.55,
        size.width * 0.22, size.height * 0.70);
    path.quadraticBezierTo(size.width * 0.30, size.height * 0.90,
        size.width * 0.40, size.height * 0.75);
    path.quadraticBezierTo(size.width * 0.52, size.height * 0.50,
        size.width * 0.65, size.height * 0.70);
    path.quadraticBezierTo(
        size.width * 0.75, size.height * 0.85, size.width, size.height * 0.60);
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, Paint()..color = Colors.blue);
  }

  @override
  bool shouldRepaint(_LudoBackgroundPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(_LudoBackgroundPainter oldDelegate) => false;
}
