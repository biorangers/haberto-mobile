import "dart:io";

import "package:flutter/material.dart";
import "package:haberto_mobile/pages/article_pages/article_pages.dart";
import "package:haberto_mobile/widgets/categories_widget.dart";
import "package:haberto_mobile/widgets/navbar_widget.dart";
import "package:haberto_mobile/widgets/newslist_widget.dart";
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  get localhost =>
      Platform.isAndroid ? 'http://10.0.2.2:5074' : 'http://localhost:5074';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  get localhost =>
      Platform.isAndroid ? 'http://10.0.2.2:5074' : 'http://localhost:5074';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              'assets/images/logoH.png',
              height: 24,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 8.0),
            const Text('Haberto'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'En Çok Okunan',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            _buildCategoryTabs(),
            _buildTrendingNews(context),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Son Dakika',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Flexible(
                    child: NewsList(
                  endpoint: '/api/News/GetAllNews/{page_number}',
                  parameters: const {
                    'page_number': '1',
                  },
                ));
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: const NavbarWidget(),
    );
  }

  Widget _buildCategoryTabs() {
    return CategoriesWidget();
  }

  Widget _buildCategoryTab(String title, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Chip(
        label: Text(
          title,
          style: TextStyle(color: isSelected ? Colors.white : Colors.green),
        ),
        backgroundColor: isSelected ? Colors.green : Colors.white,
        side: isSelected ? null : const BorderSide(color: Colors.green),
      ),
    );
  }

  Widget _buildTrendingNews(BuildContext context) {
    return FutureBuilder<List<News>>(
      future: _fetchTopNews(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final newsList = snapshot.data;
          return SizedBox(
            height: 300,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: newsList?.length,
              itemBuilder: (context, index) {
                final news = newsList?[index];
                return _buildNewsCard(
                  context,
                  news!.title,
                  news.imagePath,
                  news.id,
                  news.viewCount,
                );
              },
            ),
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Future<List<News>> _fetchTopNews() async {
    final response =
        await http.get(Uri.parse('$localhost/api/News/GetTopArticles'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      return jsonData.map<News>((json) => News.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch top news');
    }
  }

  Widget _buildNewsCard(
    BuildContext context,
    String title,
    String imagePath,
    int id,
    int viewCount,
  ) {
    return Container(
      width: 250,
      margin: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ArticlePage(id: id)),
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(16.0)),
                child: Image.network(
                  '${widget.localhost}/api/images/$imagePath',
                  height: 150,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title.length > 50 ? '${title.substring(0, 45)}...' : title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Icon(Icons.remove_red_eye,
                        size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text('$viewCount',
                        style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class News {
  final String title;
  final String imagePath;
  final int id;
  final int viewCount;

  News({
    required this.title,
    required this.imagePath,
    required this.id,
    required this.viewCount,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      title: json['articleTitle'],
      imagePath: json['articleImageURL'],
      id: json['articleID'],
      viewCount: json['articleView'],
    );
  }
}
