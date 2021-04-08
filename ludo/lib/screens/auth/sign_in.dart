import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:auth_buttons/auth_buttons.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // Use this instead of `SafeArea`
        margin: MediaQuery.of(context).viewPadding,
        padding: EdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('LUDO', style: Theme.of(context).textTheme.headline4),
          Text('Sign in to play LUDO with your friends'),
          Spacer(flex: 2),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            GoogleAuthButton(
              darkMode: Theme.of(context).brightness == Brightness.dark,
              onPressed: () {},
              iconStyle: AuthIconStyle.outlined,
              style: AuthButtonStyle.icon,
            ),
            SizedBox(width: 6.0),
            FacebookAuthButton(
              onPressed: () {},
              darkMode: Theme.of(context).brightness == Brightness.dark,
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
                darkMode: Theme.of(context).brightness == Brightness.dark,
                iconStyle: AuthIconStyle.outlined,
                style: AuthButtonStyle.icon,
              ),
            ],
          ]),
          Spacer(),
        ]),
      ),
    );
  }
}
