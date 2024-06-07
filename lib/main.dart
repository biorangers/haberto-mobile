import 'package:flutter/material.dart';
import 'package:haberto_mobile/pages/article_pages/article_pages.dart';
import 'package:haberto_mobile/pages/profile_page/profile_page.dart';
import 'package:haberto_mobile/pages/user_registration/user_login.dart';
import 'package:haberto_mobile/pages/user_registration/user_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:haberto_mobile/widgets/theme_provider.dart';
import 'package:haberto_mobile/widgets/theme_toggle_button.dart';
import 'package:haberto_mobile/pages/home_page/home_page.dart';

void main() {
  runApp(const HabertoApp());
}

class HabertoApp extends StatelessWidget {
  const HabertoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorSchemeSeed: Colors.green,
              textTheme: Theme.of(context).textTheme.apply(
                    bodyColor: Colors.black,
                    displayColor: Colors.black,
                  ),
              brightness: Brightness.light,
            ),
            darkTheme: ThemeData(
              colorSchemeSeed: Colors.green,
              textTheme: Theme.of(context).textTheme.apply(
                    bodyColor: Colors.white,
                    displayColor: Colors.white,
                  ),
              brightness: Brightness.dark,
            ),
            themeMode: themeProvider.themeMode,
            home: Scaffold(
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
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: ThemeToggleButton(), 
                      ),
                    ),
                  ],
                ),
              ),
              body: HomePage(), 
            ),
          );
        },
      ),
    );
  }
}

