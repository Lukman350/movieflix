import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkButton extends StatefulWidget {
  final int movieId;

  const BookmarkButton({super.key, required this.movieId});

  @override
  State<BookmarkButton> createState() => _BookmarkButtonState();
}

class _BookmarkButtonState extends State<BookmarkButton> {
  final Future<SharedPreferences> _preferences =
      SharedPreferences.getInstance();
  SharedPreferences? prefs;
  bool movieBookmarked = false;

  @override
  void initState() {
    super.initState();
    _preferences.then((value) => {
          setState(() {
            prefs = value;
          })
        });
  }

  Future<void> _saveBookmark(int movieId) async {
    final SharedPreferences prefs = await _preferences;
    final List<String> bookmarks =
        prefs.getStringList('bookmarks') ?? <String>[];

    if (!bookmarks.contains(movieId.toString())) {
      bookmarks.add(movieId.toString());
      await prefs.setStringList('bookmarks', bookmarks);
    }
  }

  Future<void> _removeBookmark(int movieId) async {
    final SharedPreferences prefs = await _preferences;
    final List<String> bookmarks =
        prefs.getStringList('bookmarks') ?? <String>[];

    if (bookmarks.contains(movieId.toString())) {
      bookmarks.remove(movieId.toString());
      await prefs.setStringList('bookmarks', bookmarks);
    }
  }

  Future<bool> _isBookmarked(int movieId) async {
    final SharedPreferences prefs = await _preferences;
    final List<String> bookmarks =
        prefs.getStringList('bookmarks') ?? <String>[];

    return bookmarks.contains(movieId.toString());
  }

  bool _isMovieBookmarked(int movieId) {
    final SharedPreferences? preferences = prefs;

    if (preferences == null) {
      return false;
    }

    final List<String> bookmarks =
        preferences.getStringList('bookmarks') ?? <String>[];

    return bookmarks.contains(movieId.toString());
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async {
          final bool isBookmarked = await _isBookmarked(widget.movieId);
          final snackBar = SnackBar(
            content:
                Text(isBookmarked ? 'Bookmark removed!' : 'Bookmark added!'),
            duration: const Duration(milliseconds: 500),
          );

          if (isBookmarked) {
            _removeBookmark(widget.movieId);
            setState(() {
              movieBookmarked = false;
            });
          } else {
            _saveBookmark(widget.movieId);
            setState(() {
              movieBookmarked = true;
            });
          }

          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
        icon: Icon(
          _isMovieBookmarked(widget.movieId) || movieBookmarked
              ? Icons.bookmark
              : Icons.bookmark_add_outlined,
          size: 26,
          color: Colors.black,
        ));
  }
}
