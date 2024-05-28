import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchPageBase {
  Future<List<Map<String, dynamic>>> searchArticles(
      int pageNumber, String search) async {
    final url =
        'http://localhost:5074/api/NewsOperation/SearchArticles/$pageNumber,%20$search';
    final uri = Uri.parse(url);

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = jsonDecode(response.body);

        List<Map<String, dynamic>> articles = [];

        for (var article in jsonResponse) {
          if (article is Map) {
            int? id = article['articleID'];
            String? title = article['articleTitle'];
            String? imageUrl = article['articleImageURL'];
            int? views = article['articleView'];
            String? categoryName = article['categoryName'];

            articles.add({
              'id': id,
              'title': title,
              'imageUrl': imageUrl,
              'views': views,
              'categoryName': categoryName,
            });
          }
        }

        return articles;
      } else {
        print('Failed to load data: ${response.reasonPhrase}');
        return [];
      }
    } catch (e) {
      print('Error fetching data: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getCategories() async {
    const url = 'http://localhost:5074/api/News/GetAllCategories';
    final uri = Uri.parse(url);

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = jsonDecode(response.body);

        List<Map<String, dynamic>> categories = [];

        for (var category in jsonResponse) {
          if (category is Map) {
            int? id = category['id'];
            String? name = category['categoryName'];

            categories.add({
              'id': id,
              'name': name,
            });
          }
        }

        return categories;
      } else {
        print('Failed to load data: ${response.reasonPhrase}');
        return [];
      }
    } catch (e) {
      print('Error fetching data: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> getArticlesByCategory(
      int pageNumber, int categoryId) async {
    final url =
        'http://localhost:5074/api/News/GetNewsByCategoryId/$pageNumber,%20$categoryId';
    final uri = Uri.parse(url);
    print(uri);

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = jsonDecode(response.body);

        List<Map<String, dynamic>> articles = [];

        for (var article in jsonResponse) {
          if (article is Map) {
            int? id = article['articleID'];
            String? title = article['articleTitle'];
            String? imageUrl = article['articleImageURL'];
            int? views = article['articleView'];
            int? categoryId = article['categoryID'];
            String? categoryName = article['categoryName'];

            articles.add({
              'id': id,
              'title': title,
              'imageUrl': imageUrl,
              'views': views,
              'categoryId': categoryId,
              'categoryName': categoryName,
            });
          }
        }

        return articles;
      } else {
        print('Failed to load data: ${response.reasonPhrase}');
        return [];
      }
    } catch (e) {
      print('Error fetching data: $e');
      return [];
    }
  }
}
