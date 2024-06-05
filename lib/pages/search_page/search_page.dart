import 'dart:io';
import 'package:flutter/material.dart';
import 'package:haberto_mobile/pages/search_page/search_page_base.dart';
import 'package:haberto_mobile/widgets/newslist_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final localhost =
      Platform.isAndroid ? 'http://10.0.2.2:5074' : 'http://localhost:5074';

  final SearchPageBase _searchPageBase = SearchPageBase();
  final TextEditingController _searchTextController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  String? _selectedCategory;
  String _searchText = '';

  List<Map<String, dynamic>> _categories = [];
  List<Map<String, dynamic>> _articles = [];

  int _pageNumber = 1;
  int? _selectedCategoryId;

  bool _isLoading = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    fetchCategories();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchTextController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !_isLoading &&
        _hasMore) {
      _searchText.isEmpty
          ? _searchArticlesByCategoryId(1, _selectedCategoryId!)
          : _searchArticles(1, _searchText);
    }
  }

  void _searchArticles(int pageNumber, String search) async {
    setState(() {
      _isLoading = true;
    });

    final newArticles =
        await _searchPageBase.searchArticles(pageNumber, search);

    setState(() {
      _pageNumber = pageNumber + 1;
      _searchText = search;
      if (newArticles.isEmpty) {
        _hasMore = false;
      } else {
        _articles.addAll(newArticles);
      }
      _isLoading = false;
    });
  }

  void _performSearch() {
    setState(() {
      _articles = [];
      _pageNumber = 1;
      _hasMore = true;
    });
    if (_selectedCategoryId == 0) {
      _searchArticles(1, _searchTextController.text);
    } else {
      _searchArticlesByCategoryId(1, _selectedCategoryId!);
    }
  }

  void fetchCategories() async {
    List<Map<String, dynamic>> categories =
        await _searchPageBase.getCategories();
    setState(() {
      _categories = categories;
      _categories.insert(0, {'id': 0, 'name': 'Hepsi'});
      _selectedCategory = _categories[0]['name'];
      _selectedCategoryId = _categories.firstWhere(
          (category) => category['name'] == _selectedCategory)['id'];
    });
  }

  void _searchArticlesByCategoryId(int pageNumber, int categoryId) async {
    setState(() {
      _isLoading = true;
    });

    final newArticles =
        await _searchPageBase.getArticlesByCategory(pageNumber, categoryId);

    setState(() {
      _pageNumber = pageNumber + 1;
      if (newArticles.isEmpty) {
        _hasMore = false;
      } else {
        _articles.addAll(newArticles);
      }
      _isLoading = false;
    });
  }

  void _bindCategory(int categoryName) {
    setState(() {
      _selectedCategoryId = categoryName;
      _selectedCategoryId = _categories.firstWhere(
          (category) => category['name'] == _selectedCategory)['id'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/images/logoH.png',
                    height: 24,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 8.0),
                  const Text('Haberto'),
                  const SizedBox(width: 64.0),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchTextController,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Search',
                      hintText: 'Search...',
                      labelStyle: const TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        iconSize: 32,
                        color: Theme.of(context).primaryColor,
                        onPressed: _performSearch,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(24)),
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 38, 92, 40),
                          width: 2,
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                DropdownButton<String>(
                  value: _selectedCategory,
                  onChanged: (String? value) {
                    _selectedCategory = value;
                    var selectedCategoryId = _categories.firstWhere(
                        (category) => category['name'] == value)['id'];
                    _bindCategory(selectedCategoryId);
                  },
                  items: _categories.map<DropdownMenuItem<String>>(
                      (Map<String, dynamic> category) {
                    return DropdownMenuItem<String>(
                      value: category['name'],
                      child: Text(category['name']),
                    );
                  }).toList(),
                  dropdownColor: Colors.white,
                  elevation: 4,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 32,
                  underline: Container(),
                  borderRadius: BorderRadius.circular(32.0),
                  menuMaxHeight: 250,
                ),
              ],
            ),
          ),
          _isLoading && _articles.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : NewsList(
                  endpoint:
                      '/api/NewsOperation/SearchArticles/{page_number}, {search}',
                  parameters: {
                    'page_number': _pageNumber.toString(),
                    'search': _searchText,
                  },
                ),
        ],
      ),
    );
  }
}
