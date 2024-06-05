import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';

class ThemeToggleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return IconButton(
      icon: Icon(
        themeProvider.isDarkMode ? Icons.wb_sunny : Icons.nights_stay,
        color: themeProvider.isDarkMode ? Colors.white : Colors.black,
      ),
      onPressed: () {
        final provider = Provider.of<ThemeProvider>(context, listen: false);
        provider.toggleTheme(!themeProvider.isDarkMode);
      },
    );
  }
}