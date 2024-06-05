import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ArticlePage extends StatelessWidget {
  final String articleUrl = 'https://www.example.com'; // Haber URL'si

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            SizedBox(height: 16.0),
            buildArticleImage(),
            SizedBox(height: 16.0),
            const Padding(
              padding: EdgeInsets.all(16.0),
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
                  const Text(
                    'SCREENRANT',
                    style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  const Text(
                    '3 days ago',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.visibility),
                  const SizedBox(width: 4.0),
                  const Text('123.1K'),
                  const SizedBox(width: 16.0),
                  const Icon(Icons.comment),
                  const SizedBox(width: 4.0),
                  const Text('567K'),
                  const Spacer(),
                  IconButton(
                    icon: Icon(Icons.share),
                    onPressed: () {
                      Share.share(articleUrl); // URL'yi paylaşma işlemi
                    },
                  ),
                  const SizedBox(width: 4.0),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'An MCU director wants to helm Avengers: Secret Wars, but a major criticism of his Phase 4 film might be a reason for pause. Secret Wars still doesn\'t have a director, and it will be a tremendous task for any filmmaker to undertake.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
                softWrap: true,
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
      centerTitle: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/logoH.png',
            height: 40,
          ),
          const SizedBox(width: 8),
          const Text(
            'Haberto',
            style: TextStyle(
              color: Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.normal,
              fontSize: 30,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildArticleImage() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Image.asset('assets/images/news_image.png'),
      ),
    );
  }
}
