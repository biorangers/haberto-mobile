import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ArticlePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            buildTopBar(), // Bu satırı tamamen kaldırıyoruz
            SizedBox(height: 16.0),
            buildArticleImage(),
            SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '1 Major MCU Phase 4 Movie Criticism Has Us Worried For Avengers: Secret Wars\' Director Possibility',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Text(
                    'SCREENRANT',
                    style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Text(
                    '3 days ago',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.visibility),
                  SizedBox(width: 4.0),
                  Text('123.1K'),
                  SizedBox(width: 16.0),
                  Icon(Icons.comment),
                  SizedBox(width: 4.0),
                  Text('567K'),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'An MCU director wants to helm Avengers: Secret Wars, but a major criticism of his Phase 4 film might be a reason for pause. Secret Wars still doesn\'t have a director, and it will be a tremendous task for any filmmaker to undertake.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/logoH.png',
            height: 40,
          ),
          SizedBox(width: 8),
          Text(
            'Haberto',
            style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal,
              fontSize: 30,
            ),
          ),
          SizedBox(width: 8),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.notifications),
          onPressed: () {
            // Bildirim ikonu işlemi
          },
        ),
      ],
    );
  }

  Widget buildArticleImage(){
    return Image.asset('assets/images/news_image.png');
  }

  Padding buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end, // Sağdaki ikonları hizala
        children: [
          IconButton(
            icon: Icon(Icons.bookmark_border, color: Colors.black),
            onPressed: () {
              // Yer imi butonu işlemi
            },
          ),
          IconButton(
            icon: Icon(Icons.share, color: Colors.black),
            onPressed: () {
              // Paylaşma butonu işlemi
            },
          ),
          IconButton(
            icon: Icon(Icons.download, color: Colors.black),
            onPressed: () {
              // İndir butonu işlemi
            },
          ),
        ],
      ),
    );
  }
}
