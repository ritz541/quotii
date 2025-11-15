import 'package:flutter/material.dart';
import 'package:quotii/home_page.dart';
import 'package:quotii/favorites_page.dart';
import 'package:quotii/settings_page.dart';

class MainPage extends StatefulWidget {
  final void Function() toggleMode;
  final bool isDark;

  const MainPage({required this.toggleMode, required this.isDark, super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomePage(toggleMode: widget.toggleMode, isDark: widget.isDark),
      const FavoritesPage(),
      SettingsPage(toggleMode: widget.toggleMode, isDark: widget.isDark),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Update pages with current state
    _pages[0] = HomePage(toggleMode: widget.toggleMode, isDark: widget.isDark);
    _pages[2] = SettingsPage(
      toggleMode: widget.toggleMode,
      isDark: widget.isDark,
    );

    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xff1e1e1e) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? Colors.white : Colors.black,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.white.withOpacity(0.1)
                  : Colors.black.withOpacity(0.1),
              offset: const Offset(4, 4),
              blurRadius: 0,
              spreadRadius: 0,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: NavigationBar(
            selectedIndex: _currentIndex,
            onDestinationSelected: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            indicatorColor: Colors.deepPurple.withOpacity(0.2),
            backgroundColor: Colors.transparent,
            elevation: 0,
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.format_quote),
                label: 'Quotes',
              ),
              NavigationDestination(
                icon: Icon(Icons.favorite),
                label: 'Favorites',
              ),
              NavigationDestination(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
