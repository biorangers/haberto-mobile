import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UserLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Image.asset(
            'assets/images/logo.png',
            width: 200,
          ),
          const Text(
            'HABERTO',
            style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontSize: 30,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          const Text(
            'Welcome to Haberto! Let\'s dive into your account!',
            style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontSize: 16,
              fontStyle: FontStyle.normal,
              decoration: TextDecoration.none,
            ),
            softWrap: true,
          ),
          const SizedBox(height: 60),
          OutlinedButton.icon(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              foregroundColor: Color.fromARGB(255, 35, 35, 35),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(42)),
              ),
              side: const BorderSide(
                color: Color.fromARGB(255, 166, 166, 166),
                width: 1,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
            ),
            icon: Image.asset(
              'assets/images/google.png',
              width: 24,
            ),
            label: const Text(
              'Continue with Google',
              style: TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          const Row(children: <Widget>[
            Expanded(
              child: Divider(
                color: Color.fromARGB(255, 166, 166, 166),
                thickness: 1,
                indent: 20,
                endIndent: 20,
              ),
            ),
            Text(
              'or',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Divider(
                color: Color.fromARGB(255, 166, 166, 166),
                thickness: 1,
                indent: 20,
                endIndent: 20,
              ),
            ),
          ]),
        ]),
      ),
    ));
  }
}
