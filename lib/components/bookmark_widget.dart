import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookmarkButton extends StatelessWidget {
  final Future<SharedPreferences> _preferences =
      SharedPreferences.getInstance();
  final int movieId;

  BookmarkButton({super.key, required this.movieId});

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

  bool _checkBookmark(int movieId) {
    bool isMovieBookmarked = false;
    _isBookmarked(movieId).then((value) => isMovieBookmarked = value);
    return isMovieBookmarked;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final bool isBookmarked = await _isBookmarked(movieId);
        final snackBar = SnackBar(
          content: Text(isBookmarked ? 'Bookmark removed!' : 'Bookmark added!'),
          duration: const Duration(seconds: 2),
        );

        if (isBookmarked) {
          _removeBookmark(movieId);
        } else {
          _saveBookmark(movieId);
        }

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      icon: Icon(
        _checkBookmark(movieId) ? Icons.bookmark : Icons.bookmark_add_outlined,
        size: 26,
        color: Colors.black,
      ),
    );
  }
}
