import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const HabertoApp());
}

class HabertoApp extends StatelessWidget {
  const HabertoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const HomePage(),
    );
  }
}

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
              'assets/images/mcu_news.png', // TODO 1: Add Haberto logo
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
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            _buildCategoryTab('All', true),
            _buildCategoryTab('Politics', false),
            _buildCategoryTab('Technology', false),
            _buildCategoryTab('Business', false),
            // Diğer kategoriler buraya eklenebilir
          ],
        ),
      ),
    );
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
              567000),
          _buildNewsCard(
              context,
              'Spider-Man Fixing No Way Home\'s Biggest Overcorrection',
              'assets/images/mcu_news.png',
              'CBR',
              234.2,
              678000),
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
              450000),
          _buildNewsCard(
              context,
              'Why Batman Begins Is Still The Best Batman Movie',
              'assets/images/mcu_news.png',
              'CBR',
              112.4,
              470000),
          // Diğer haber kartları buraya eklenebilir
        ],
      ),
    );
  }

  Widget _buildNewsCard(BuildContext context, String title, String imagePath,
      String source, double views, int likes) {
    return Container(
      width: 250,
      margin: const EdgeInsets.all(8.0),
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
                title,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                  Text('${views}K', style: const TextStyle(color: Colors.grey)),
                  const SizedBox(width: 8),
                  const Icon(Icons.favorite, size: 16, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text('$likes', style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
