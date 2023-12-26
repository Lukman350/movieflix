import 'package:flutter/material.dart';
import 'package:movieflix/components/app_bar.dart';
import 'package:movieflix/screens/home_screen.dart';

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
    const Text('Search'),
    const Text('Bookmark'),
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
              icon: Icon(Icons.movie_rounded),
              tooltip: 'Home',
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search_rounded),
              tooltip: 'Search',
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark_outline_rounded),
              tooltip: 'Bookmark',
              label: 'Bookmark',
            ),
          ],
        ),
      ),
    );
  }
}
