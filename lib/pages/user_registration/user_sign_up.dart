import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class UserSignUp extends StatelessWidget {
  const UserSignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sign Up",
          style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold),
        ),
        // backgroundColor: Theme.of(context).colorScheme.primary,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            // color: Theme.of(context).colorScheme.onPrimary,
            color: Color.fromARGB(255, 38, 92, 40),
            size: 32,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Image.asset(
            'assets/images/logoH.png',
            width: 200,
          ),
          const SizedBox(height: 20),
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
          const SizedBox(height: 50),
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
          const SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              // backgroundColor: Theme.of(context).colorScheme.primary,
              backgroundColor: const Color.fromARGB(255, 38, 92, 40),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(42),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 75, vertical: 20),
            ),
            child: const Text(
              'Sign in with password',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 40),
          RichText(
            text: TextSpan(
              children: <TextSpan>[
                const TextSpan(
                  text: "Don't have an account? ",
                  style: TextStyle(color: Colors.black),
                ),
                TextSpan(
                  text: ' Sign up',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 73, 145, 75),
                    fontWeight: FontWeight.bold,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UserSignUp()),
                      );
                    },
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
