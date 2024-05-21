import 'package:flutter/material.dart';
import 'package:haberto_mobile/pages/article_pages/article_pages.dart';


void main() {
  runApp(HabertoApp());
}

class HabertoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Haberto',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: ArticlePage(),
    );
  }
}
