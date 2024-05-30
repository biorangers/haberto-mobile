import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _username = "John Doe";
  String _about =
      "This is a brief about me section. I love Flutter and mobile development.";
  String _role = "Author";
  String _email = "john.doe@example.com";
  String _creationDate = "2023-01-01";
  bool _isActive = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/logoH.png',
                    height: 32,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 8.0),
                  const Text('Haberto', style: TextStyle(fontSize: 32)),
                  const SizedBox(width: 64.0),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                  'https://www.w3schools.com/howto/img_avatar.png'),
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          _username,
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.verified_rounded,
                          size: 24,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            _username = "Jane Smith";
                            _about =
                                "Hello! I'm Jane, a passionate Flutter developer.";
                            _role = "Lead Developer";
                            _email = "jane.smith@example.com";
                            _creationDate = "2024-01-01";
                            _isActive = false;
                          });
                        },
                        icon: const Icon(Icons.edit_square))
                  ],
                ),
                Text(
                  "Role: $_role",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _about,
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 10),
                Text(
                  _email,
                  style: TextStyle(
                      fontSize: 20,
                      color: Theme.of(context).colorScheme.secondary),
                ),
              ],
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
              Icon(Icons.arrow_downward_rounded),
              Expanded(
                child: Divider(
                  color: Color.fromARGB(255, 166, 166, 166),
                  thickness: 1,
                  indent: 20,
                  endIndent: 20,
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
