import 'package:flutter/material.dart';
import "dart:io";
import "package:http/http.dart" as http;
import 'dart:convert';
import 'share_plus/share_plus.dart';

class ArticlePage extends StatelessWidget {
  final int id;
  get localhost =>
      Platform.isAndroid ? 'http://10.0.2.2:5074' : 'http://localhost:5074';

  const ArticlePage({super.key, required this.id});

  final String articleUrl = 'https://www.example.com'; // Örnek haber URL'si

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Article>(
      future: fetchArticle(id),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final article = snapshot.data!;
          return Scaffold(
            appBar: buildAppBar(),
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  const SizedBox(height: 16.0),
                  buildArticleImage(article.imageUrl),
                  const SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      article.title,
                      style: const TextStyle(
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
                          article.date.toString(),
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        const Spacer(),
                        const Icon(Icons.visibility),
                        const SizedBox(width: 4.0),
                        Text(article.views.toString()),
                        const SizedBox(width: 16.0),
                        IconButton(
                          icon: const Icon(Icons.share),
                          onPressed: () {
                            Share.share(articleUrl);
                          },
                        ),
                        const SizedBox(width: 4.0),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      article.content,
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
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

  Widget buildArticleImage(String imageUrl) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Image.network(
          '$localhost/api/images/$imageUrl',
          height: 200,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Future<Article> fetchArticle(int id) async {
    final response =
        await http.get(Uri.parse('$localhost/api/News/GetNewsById/$id'));
    if (response.statusCode == 200) {
      return Article.fromJson(jsonDecode(response.body)[0]);
    } else {
      throw Exception('Failed to fetch article');
    }
  }
}

class Article {
  final int id;
  final String title;
  final String content;
  final String imageUrl;
  final DateTime date;
  final int views;
  final String category;
  final int authorId;
  final String author;

  Article({
    required this.id,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.date,
    required this.views,
    required this.category,
    required this.authorId,
    required this.author,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['articleID'],
      title: json['articleTitle'],
      content: json['articleContent'],
      imageUrl: json['articleImageURL'],
      date: DateTime.parse(json['articlePublishedDate']),
      views: json['articleView'],
      category: json['categoryName'],
      authorId: json['authorID'],
      author: json['author'],
    );
  }
}
