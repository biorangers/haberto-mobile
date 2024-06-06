import 'package:flutter/material.dart';
import 'package:haberto_mobile/pages/editor_page/editor_page.dart';
import 'package:haberto_mobile/pages/profile_page/profile_page_base.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ProfilePageBase _profilePageBase = ProfilePageBase();
  final ScrollController _scrollController = ScrollController();

  String _username = '';
  String _about = '';
  String _role = '';
  String _email = '';
  String _userStatus = '';
  String _imageUrlStr = '';

  bool _isActive = false;
  bool _isOnWaiting = false;

  List<Map<String, dynamic>> _articles = [];

  bool _isLoading = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _loadUserId();
    _scrollController.addListener(_scrollListener);
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
      _loadUserId();
    }
  }

  Future<void> fetchAndProcessArticles(String pageNumber, String id) async {
    _articles = await _profilePageBase.getArticlesByUserId(pageNumber, id);
  }

  Future<void> _loadUserId() async {
    String? userId = await getUserId();
    if (userId != null) {
      _getUserById(userId.toString());
      fetchAndProcessArticles('1', userId.toString());
    }
  }

  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('user_id');
    print("Kullanıcı ID'si getirildi: $userId");
    return userId;
  }

  void _getUserById(String id) async {
    final users = await _profilePageBase.getUserById(id);

    if (users.isNotEmpty) {
      setState(() {
        _username = users[0]['name'] + ' ' + users[0]['surname'];
        _about = users[0]['bio'];
        _email = users[0]['email'];
        _role = users[0]['role'];
        _userStatus = users[0]['status'];
        final _imageUrl = users[0]['imageUrl'];
        _imageUrlStr = 'http://localhost:5074/api/images/$_imageUrl';
      });
      _handleUserStatus();
    }
  }

  void _handleUserStatus() {
    print(_isOnWaiting);
    switch (_userStatus) {
      case 'Aktif':
        setState(() {
          _isActive = true;
        });
        break;
      case 'Pasif':
        setState(() {
          _isActive = false;
        });
        break;
      case 'Beklemede':
        setState(() {
          _isOnWaiting = true;
          print(_isOnWaiting);
        });
      default:
        setState(() {
          _isActive = false;
        });
    }
  }

  void _editArticle(
      String newTitle, String newContent, String selectedCategory) {
    print('Article editing is not implemented yet.');
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
                      height: 32,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 8.0),
                    const Text('Haberto', style: TextStyle(fontSize: 32)),
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
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(_imageUrlStr),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                _username,
                                style: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(width: 8),
                              Icon(
                                _isActive
                                    ? Icons.verified
                                    : _isOnWaiting
                                        ? Icons.watch_later_outlined
                                        : Icons.block,
                                size: 24,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ],
                          ),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  _username = "Jane Smith";
                                  _about =
                                      "Hello! I'm Jane, a passionate Flutter developer.";
                                  _role = "Lead Developer";
                                  _email = "jane.smith@example.com";
                                  _isActive = false;
                                });
                              },
                              icon: const Icon(Icons.edit_square))
                        ],
                      ),
                      Text(
                        "Role: $_role",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _about,
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _email,
                        style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Row(children: <Widget>[
                    Expanded(
                      child: Divider(
                        color: Color.fromARGB(255, 166, 166, 166),
                        thickness: 1,
                        indent: 20,
                        endIndent: 20,
                      ),
                    ),
                    Icon(Icons.arrow_downward_rounded),
                    Expanded(
                      child: Divider(
                        color: Color.fromARGB(255, 166, 166, 166),
                        thickness: 1,
                        indent: 20,
                        endIndent: 20,
                      ),
                    ),
                  ]),
                ],
              ),
            ),
            _isLoading && _articles.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
                    child: _articles.isEmpty
                        ? const Center(child: Text('No articles found.'))
                        : ListView.builder(
                            controller: _scrollController,
                            itemCount: _articles.length + (_hasMore ? 1 : 0),
                            itemBuilder: (context, index) {
                              if (index == _articles.length) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              final article = _articles[index];
                              final image = article['articleImageURL'];
                              return Card(
                                child: ListTile(
                                  leading: image != null
                                      ? Image(
                                          image: NetworkImage(
                                              'http://localhost:5074/api/images/$image'),
                                        )
                                      : const SizedBox(),
                                  title: Text(
                                    article['articleTitle'] ?? 'No title',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                    softWrap: true,
                                    maxLines: 3,
                                  ),
                                  subtitle: Text(
                                      article['categoryName'] ?? 'No category'),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    EditorPage(
                                                      articleId:
                                                          article['articleID'],
                                                    )),
                                          );
                                        },
                                        icon: const Icon(Icons.edit),
                                      ),
                                      const SizedBox(width: 4)
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
          ],
        ));
  }
}
