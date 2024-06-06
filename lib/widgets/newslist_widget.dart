import 'dart:io';

import 'package:flutter/material.dart';
import 'package:haberto_mobile/pages/article_pages/article_pages.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsList extends StatefulWidget {
  final localhost =
      Platform.isAndroid ? 'http://10.0.2.2:5074' : 'http://localhost:5074';
  final String endpoint;
  final Map<String, String> parameters;

  NewsList({required this.endpoint, required this.parameters});

  @override
  _NewsListState createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  final ScrollController _scrollController = ScrollController();
  List<Map<String, dynamic>> _articles = [];
  int _pageNumber = 1;
  bool _isLoading = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    _fetchArticles();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !_isLoading &&
        _hasMore) {
      _fetchArticles();
    }
  }

  void _fetchArticles() async {
    setState(() {
      _isLoading = true;
      _pageNumber++;
    });

    String url = '${widget.localhost}${widget.endpoint}';
    widget.parameters.forEach((key, value) {
      url = url.replaceAll('{$key}', value);
      if (key == 'page_number') {
        print('Page number: $_pageNumber');
        url = url.replaceAll('{$key}', _pageNumber.toString());
      }
    });

    print(url);
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = jsonDecode(response.body);
        setState(() {
          if (jsonResponse.isEmpty) {
            _hasMore = false;
          } else {
            _articles.addAll(jsonResponse
                .map((article) => {
                      'id': article['articleID'],
                      'title': article['articleTitle'],
                      'imageUrl': article['articleImageURL'],
                      'views': article['articleView'],
                      'categoryName': article['categoryName'],
                    })
                .toList());
            _pageNumber++;
          }
        });
      } else {
        print('Failed to load data: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading && _articles.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : Expanded(
            child: _articles.isEmpty
                ? const Center(child: Text('No articles found.'))
                : ListView.builder(
                    shrinkWrap: true,
                    controller: _scrollController,
                    itemCount: _articles.length + (_hasMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == _articles.length) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      final article = _articles[index];
                      return Card(
                        child: ListTile(
                          leading: article['imageUrl'] != null
                              ? Image.network(
                                  '${widget.localhost}/api/images/${article['imageUrl']}',
                                  height: 50,
                                  width: 80,
                                  fit: BoxFit.cover,
                                )
                              : null,
                          title: Text(
                            article['title'] ?? 'No title',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            softWrap: true,
                            maxLines: 3,
                          ),
                          subtitle:
                              Text(article['categoryName'] ?? 'No category'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.remove_red_eye),
                              const SizedBox(width: 4),
                              Text(article['views'].toString()),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ArticlePage(id: article['id']),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
          );
  }
}
