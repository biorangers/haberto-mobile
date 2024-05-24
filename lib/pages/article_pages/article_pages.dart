import 'package:flutter/material.dart';

class ArticlePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Image.asset(
              'assets/images/logoH.png',
              height: 32,
            ),
            SizedBox(width: 8),
            Text(
              'Haberto',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
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
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            // Geri butonu ve metni ile diğer butonlar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_back,
                          color: Colors.green,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'Back',
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
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
                ],
              ),
            ),
            SizedBox(height: 16.0),
            // Haber görseli
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.asset(
                  'assets/images/news_image.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            // Haber başlığı
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
            // Kaynak ve tarih
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
            // Haber içeriği
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'An MCU director wants to helm Avengers: Secret Wars, but a major criticism of his Phase 4 film might be a reason for pause. Secret Wars still doesn\'t have a director, and it will be a tremendous task for any filmmaker to undertake.',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
            // Daha fazla içerik buraya eklenebilir
          ],
        ),
      ),
    );
  }
}
