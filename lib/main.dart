import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:haberto_mobile/widgets/theme_provider.dart';
import 'package:haberto_mobile/widgets/theme_toggle_button.dart';
import 'package:haberto_mobile/pages/article_pages/article_pages.dart';
import 'package:haberto_mobile/pages/article_pages/article_pages.dart';
import 'package:haberto_mobile/pages/home_page/home_page.dart';
import 'package:haberto_mobile/pages/search_page/search_page.dart';
import 'package:haberto_mobile/pages/search_page/search_page_base.dart';
import 'package:haberto_mobile/pages/user_registration/user_login.dart';


void main() {
  runApp(const HabertoApp());
}

class HabertoApp extends StatelessWidget {
  const HabertoApp({super.key});

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
            home: HomePage(),
          );
        },
      ),
    );
  }
}
