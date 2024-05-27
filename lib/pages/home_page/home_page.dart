import "package:flutter/material.dart";
import "package:haberto_mobile/pages/article_pages/article_pages.dart";
import "package:haberto_mobile/widgets/categories_widget.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Trending News',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            _buildCategoryTabs(),
            _buildTrendingNews(context),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Global Stories',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            _buildGlobalStories(context),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Discover',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Bookmark',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
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
    return SizedBox(
      height: 300,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildNewsCard(
              context,
              '1 Major MCU Phase 4 Movie Criticism Has Us Worried For Avengers: Secret Wars\' Director Possibility',
              'assets/images/mcu_news.png',
              'SCREENRANT',
              123.1,
              5.67),
          _buildNewsCard(
              context,
              'Spider-Man Fixing No Way Home\'s Biggest Overcorrection',
              'assets/images/mcu_news.png',
              'CBR',
              234.2,
              6.7),
          // Diğer haber kartları buraya eklenebilir
        ],
      ),
    );
  }

  Widget _buildGlobalStories(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildNewsCard(
              context,
              'Captain America: The First Avenger - Revisiting The MCU\'s Most Underrated Movie',
              'assets/images/mcu_news.png',
              'SCREENRANT',
              98.3,
              4.5),
          _buildNewsCard(
              context,
              'Why Batman Begins Is Still The Best Batman Movie',
              'assets/images/mcu_news.png',
              'CBR',
              112.4,
              4.7),
          // Diğer haber kartları buraya eklenebilir
        ],
      ),
    );
  }

  Widget _buildNewsCard(BuildContext context, String title, String imagePath,
      String source, double views, double likes) {
    return Container(
      width: 250,
      margin: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ArticlePage()),
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
                child: Image.asset(
                  imagePath,
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
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  source,
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    const Icon(Icons.access_time, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    const Text('3 days ago',
                        style: TextStyle(color: Colors.grey)),
                    const Spacer(),
                    const Icon(Icons.remove_red_eye,
                        size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text('${views}K',
                        style: const TextStyle(color: Colors.grey)),
                    const SizedBox(width: 8),
                    const Icon(Icons.favorite, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text('${likes}K',
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
