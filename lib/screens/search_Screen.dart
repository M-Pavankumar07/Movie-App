import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie/State/search_provider.dart';
import 'package:movie/screens/movie_details_Screen.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  String getImageUrl(String? path) {
    if (path == null || path.isEmpty) {
      return '';
    } else {
      return 'https://image.tmdb.org/t/p/w500$path';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchResults = ref.watch(searchMoviesProvider);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: TextField(
          onChanged: (value){
            ref.read(searchQueryProvider.notifier).state = value;
          },
        ),
      ),
      body: searchResults.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Text('Error: $e', style: const TextStyle(color: Colors.white)),
        ),
        data: (movies) {
          if (movies.isEmpty) {
            return const Center(
              child: Text(
                "Search movies...",
                style: TextStyle(color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return SizedBox(
                width: double.infinity,
                child: ListTile(
                  leading: movie['poster_path'] == null
                      ? Image.asset(
                          'assets/image.png',
                          width: 50,
                          fit: BoxFit.cover,
                      )
                  
                  :Image.network(
                    getImageUrl(movie['poster_path']),
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(
                    movie['title'] ?? "",
                    style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color),
                  ),
                  subtitle: Text(
                    movie['release_date'] ?? "",
                    style: TextStyle(color: Theme.of(context).textTheme.bodyMedium!.color),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailsScreen(movie: movie),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
