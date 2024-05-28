import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:quill_html_editor/quill_html_editor.dart';
import 'package:http/http.dart' as http;

class EditorPage extends StatefulWidget {
  const EditorPage({super.key, required this.articleId});
  final int articleId;

  @override
  _EditorPageState createState() => _EditorPageState();
}

class _EditorPageState extends State<EditorPage> {
  var article = <String, dynamic>{};
  final QuillEditorController controller = QuillEditorController();
  bool isLoading = true;
  bool isUpdating = false;
  List<dynamic> categories = [];
  String selectedCategory = "";
  String uploadedFile = "";

  @override
  void initState() {
    super.initState();
    fetchInitialData();
  }

  Future<void> fetchInitialData() async {
    final articleId = widget.articleId;
    try {
      final fetchedArticle = await getArticle(articleId);
      final fetchedCategories = await getCategories();
      setState(() {
        article = fetchedArticle;
        categories = fetchedCategories;
        selectedCategory = fetchedCategories.first['id'].toString();
        uploadedFile = fetchedArticle['articleImageURL'] ?? "";
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<Map<String, dynamic>> getArticle(int articleId) async {
    final url =
        Platform.isAndroid ? 'http://10.0.2.2:5074' : 'http://localhost:5074';
    final response = await http
        .get(Uri.parse('$url/api/News/GetNewsById/$articleId'), headers: {
      'Accept': 'application/json',
      'Accept-Charset': 'utf-8',
    });
    if (response.statusCode == 200) {
      final articleJson = json.decode(response.body);
      if (articleJson.isNotEmpty) {
        return articleJson[0];
      } else {
        return {};
      }
    } else {
      throw Exception('Failed to load article');
    }
  }

  Future<List<dynamic>> getCategories() async {
    final url =
        Platform.isAndroid ? 'http://10.0.2.2:5074' : 'http://localhost:5074';
    final response =
        await http.get(Uri.parse('$url/api/News/GetAllCategories'), headers: {
      'Accept': 'application/json',
      'Accept-Charset': 'utf-8',
    });
    if (response.statusCode == 200) {
      final categoriesJson = json.decode(response.body);
      return categoriesJson;
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<void> updateArticle() async {
    setState(() {
      isUpdating = true;
    });
    final url =
        Platform.isAndroid ? 'http://10.0.2.2:5074' : 'http://localhost:5074';
    final articleContent = await controller.getText();
    final response = await http.put(
      Uri.parse('$url/api/NewsOperation/UpdateArticle/${article['articleID']}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'articleID': article['articleID'],
        'categoryID': selectedCategory,
        'permissionID': 1,
        'articleTitle': article['articleTitle'],
        'articleContent': articleContent,
        'ImageURL': uploadedFile,
      }),
    );
    if (response.statusCode == 200) {
      print('Article updated successfully');
    } else {
      print('Failed to update article');
    }
    setState(() {
      isUpdating = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editor'),
        actions: [
          IconButton(
            icon: isUpdating
                ? const CircularProgressIndicator(color: Colors.white)
                : const Icon(Icons.save),
            onPressed: isUpdating
                ? null
                : () async {
                    await updateArticle();
                  },
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: TextEditingController(
                        text: article['articleTitle'] ?? ''),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Title',
                    ),
                    onChanged: (value) {
                      article['articleTitle'] = value;
                    },
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: selectedCategory,
                    items: categories.map<DropdownMenuItem<String>>((category) {
                      return DropdownMenuItem<String>(
                        value: category['id'].toString(),
                        child: Text(category['categoryName']),
                      );
                    }).toList(),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Category',
                    ),
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value!;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  // TODO Fıle upload işlemi file picker

                  const SizedBox(height: 16),
                  ToolBar(
                    padding: const EdgeInsets.all(8),
                    iconSize: 20,
                    controller: controller,
                    customButtons: [
                      InkWell(onTap: () {}, child: const Icon(Icons.favorite)),
                      InkWell(
                          onTap: () {}, child: const Icon(Icons.add_circle)),
                    ],
                  ),
                  Expanded(
                    child: QuillHtmlEditor(
                      text: article['articleContent'] ?? '',
                      controller: controller,
                      isEnabled: true,
                      minHeight: 300,
                      textStyle: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                      hintTextStyle: const TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                      hintTextAlign: TextAlign.start,
                      padding: const EdgeInsets.only(left: 10, top: 5),
                      hintTextPadding: EdgeInsets.zero,
                      onEditorCreated: () {
                        controller.setText(article['articleContent'] ?? '');
                      },
                      loadingBuilder: (context) {
                        return const Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
