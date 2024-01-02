import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movieflix/api/movies.dart';
import 'package:movieflix/components/movie_card.dart';
import 'package:movieflix/components/skeletons/movie_card.dart';
import 'package:movieflix/models/movie_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String _searchText = '';
  static const _pageSize = 20;
  final PagingController<int, Movie> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await Api.searchMovies(_searchText, page: pageKey);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
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
        firstPageErrorIndicatorBuilder: (_) => const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.search,
                color: Color.fromARGB(255, 17, 14, 71),
                size: 80,
              ),
              SizedBox(height: 16),
              Text(
                'Search for movies',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Color.fromARGB(255, 17, 14, 71),
                ),
              ),
            ],
          ),
        ),
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
                'No movies found',
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
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          decoration: const InputDecoration(
              hintText: 'Search movies...',
              hintStyle: TextStyle(
                color: Colors.grey,
              ),
              suffixIcon: Icon(Icons.search)),
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
          onSubmitted: (value) {
            setState(() {
              _searchText = value;
            });

            _pagingController.refresh();
          },
        ),
      ),
      body: Padding(padding: const EdgeInsets.all(8.0), child: _buildBody()),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
