import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:haberto_mobile/models/category.dart';
import 'package:http/http.dart' as http;

class CategoriesWidget extends StatefulWidget {
  @override
  _CategoriesWidgetState createState() => _CategoriesWidgetState();
}

class _CategoriesWidgetState extends State<CategoriesWidget> {
  late Future<List<Category>> _categoriesFuture;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _categoriesFuture = fetchCategories();
  }

  Future<List<Category>> fetchCategories() async {
    final url = Platform.isAndroid
        ? 'http://10.0.2.2:5074'
        : 'http://localhost:5074'; // ? Android emulator : iOS emulator

    final response =
        await http.get(Uri.parse('$url/api/News/GetAllCategories'), headers: {
      'Accept': 'application/json',
      'Accept-Charset': 'utf-8',
    });

    if (response.statusCode == 200) {
      final List<dynamic> categoryJson = json.decode(response.body);
      categoryJson.insert(0, {'id': -1, 'categoryName': 'Tümü'});
      return categoryJson.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  void _onCategorySelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Category>>(
      future: _categoriesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Kategoriler bulunamadı.'));
        } else {
          return Categories(
            categories: snapshot.data!,
            selectedIndex: _selectedIndex,
            onCategorySelected: _onCategorySelected,
          );
        }
      },
    );
  }
}

class Categories extends StatelessWidget {
  final List<Category> categories;
  final int selectedIndex;
  final Function(int) onCategorySelected;

  const Categories({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: categories
              .asMap()
              .entries
              .map(
                (entry) => _buildCategoryTab(
                  context,
                  index: entry.key,
                  category: entry.value,
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  Widget _buildCategoryTab(
    BuildContext context, {
    required int index,
    required Category category,
  }) {
    final isSelected = index == selectedIndex;

    return GestureDetector(
      onTap: () => onCategorySelected(index),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 8.0,
        ),
        margin: const EdgeInsets.only(right: 8.0),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Text(
          category.name,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
