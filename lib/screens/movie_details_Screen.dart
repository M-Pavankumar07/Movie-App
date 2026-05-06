import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie/State/favorites_provider.dart';

class MovieDetailsScreen extends ConsumerWidget {
  final Map movie;
  const MovieDetailsScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favNotifier = ref.read(favoritesProvider.notifier);
    final isFav = ref
        .watch(favoritesProvider)
        .any((m) => m['id'] == movie['id']);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                "https://image.tmdb.org/t/p/w500${movie['poster_path']}",
              ),
              const SizedBox(height: 10),
              Text(
                movie['title'] ?? "",
                style: const TextStyle(color: Colors.white, fontSize: 20),
              ),
              const SizedBox(height: 10),
              Text(
                movie['overview'] ?? "",
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),

              const SizedBox(height: 20),

              ElevatedButton.icon(
                onPressed: () {
                  favNotifier.toggleFavorite(movie);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        isFav ? "Removed from Favorites" : "Added to Favorites",
                      ),
                    ),
                  );
                  
                },
                icon:
                  Icon(
                    isFav ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                  ),
                label: Text(isFav ? "Remove from Favorites" : "Add to Favorites"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
