import 'package:flutter/material.dart';
import 'package:movieflix/components/app_bar.dart';
import 'package:movieflix/screens/bookmark_screen.dart';
import 'package:movieflix/screens/home_screen.dart';
import 'package:movieflix/screens/search_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const SearchScreen(),
    BookmarkScreen(),
  ];

  static final List<Widget> _appBarOptions = <Widget>[
    const MyAppBar(),
    const MyAppBar(),
    const MyAppBar(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: const MaterialColor(
            0xFF111447,
            <int, Color>{
              50: Color(0xFFE7E9FF),
              100: Color(0xFFC4C9FF),
              200: Color(0xFF9EA7FF),
              300: Color(0xFF7885FF),
              400: Color(0xFF5766FF),
              500: Color(0xFF3548FF),
              600: Color(0xFF2A3DE6),
              700: Color(0xFF2234C4),
              800: Color(0xFF1A2C9E),
              900: Color(0xFF121F73),
            },
          ),
        ),
        fontFamily: DefaultTextStyle.of(context).style.fontFamily,
        fontFamilyFallback:
            DefaultTextStyle.of(context).style.fontFamilyFallback,
      ),
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: _appBarOptions.elementAt(
            _currentIndex,
          ),
        ),
        body: _widgetOptions.elementAt(
          _currentIndex,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
          selectedItemColor: const Color.fromARGB(255, 17, 14, 71),
          backgroundColor: Colors.white,
          iconSize: 24,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          elevation: 10,
          unselectedIconTheme: const IconThemeData(
            color: Color.fromARGB(255, 216, 216, 216),
          ),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.movie_creation_outlined),
              tooltip: 'Home',
              label: 'Home',
              activeIcon: Icon(Icons.movie_creation_rounded),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined),
              tooltip: 'Search',
              label: 'Search',
              activeIcon: Icon(Icons.search_rounded),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_outline_rounded),
              tooltip: 'Bookmark',
              label: 'Bookmark',
              activeIcon: Icon(Icons.bookmark_rounded),
            ),
          ],
        ),
      ),
    );
  }
}
