import 'package:flutter/material.dart';
import 'package:haberto_mobile/pages/search_page/search_page.dart';

class NavbarWidget extends StatefulWidget {
  const NavbarWidget({super.key});

  @override
  _NavbarWidgetState createState() => _NavbarWidgetState();
}

class _NavbarWidgetState extends State<NavbarWidget> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    print('INDEX: ' + index.toString());
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        // Ana sayfa
        break;
      case 1:
        print('INDEX: ' + index.toString());
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SearchPage()),
        );
        break;
      case 2:
        // Kaydedilenler
        break;
      case 3:
        // Profil
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Ana Sayfa',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Arama',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profil',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.grey,
      onTap: _onItemTapped,
    );
  }
}
