import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movieflix/api/movies.dart';
import 'package:movieflix/components/movie_card.dart';
import 'package:movieflix/components/skeletons/movie_card.dart';
import 'package:movieflix/models/movie_model.dart';

enum MovieType { nowPlaying, popular }

class SeeMoreScreen extends StatefulWidget {
  final MovieType type;

  const SeeMoreScreen({super.key, required this.type});

  @override
  State<SeeMoreScreen> createState() => _SeeMoreScreenState();
}

class _SeeMoreScreenState extends State<SeeMoreScreen> {
  static const _pageSize = 20;
  final PagingController<int, Movie> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = widget.type == MovieType.nowPlaying
          ? await Api.getNowPlayingMovies(page: pageKey, full: true)
              as List<Movie>
          : await Api.getPopularMovies(page: pageKey);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  Widget _buildBody() {
    return PagedListView<int, Movie>(
      padding: const EdgeInsets.all(6.0),
      pagingController: _pagingController,
      scrollDirection: Axis.vertical,
      builderDelegate: PagedChildBuilderDelegate<Movie>(
        animateTransitions: true,
        transitionDuration: const Duration(milliseconds: 500),
        noItemsFoundIndicatorBuilder: (_) => const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error,
                color: Colors.red,
                size: 80,
              ),
              SizedBox(height: 16),
              Text(
                'There are no movies to show',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
        newPageProgressIndicatorBuilder: (_) => const MovieCardSkeletonSingle(),
        itemBuilder: (context, item, index) => MovieCard(
          grid: true,
          movie: item,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.type == MovieType.nowPlaying
              ? 'Now Playing'
              : 'Popular Movies',
          style: const TextStyle(
            color: Color.fromARGB(255, 17, 14, 71),
            fontSize: 24,
            fontWeight: FontWeight.w900,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: _buildBody(),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
