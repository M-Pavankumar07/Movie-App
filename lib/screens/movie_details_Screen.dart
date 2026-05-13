import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie/State/favorites_provider.dart';
import 'package:movie/screens/cast_Screen.dart';
import 'package:movie/screens/trailer_Screen.dart';
import 'package:movie/services/trailer_service.dart';
import 'package:movie/utils/flutter_toast_message.dart';

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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
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
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium!.copyWith(fontSize: 20),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 22),

                  const SizedBox(width: 5),

                  Text(
                    "${movie['vote_average'].toStringAsFixed(1)}/10",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),

                  const SizedBox(width: 20),

                  const Icon(Icons.calendar_today, size: 18),

                  const SizedBox(width: 5),

                  Text(
                    movie['release_date'] ?? "N/A",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Text(
                'Overview',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              Text(
                movie['overview'] ?? "No description available",
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  height: 1.6,
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                ),
              ),

              const SizedBox(height: 25),

              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          const Icon(Icons.movie, color: Colors.red),
                          const SizedBox(height: 8),
                          const Text(
                            'Language',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            movie['original_language']?.toUpperCase() ?? "N/A",
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).textTheme.bodyMedium!.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          const Icon(Icons.trending_up, color: Colors.green),
                          const SizedBox(height: 8),
                          const Text(
                            'Popularity',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            movie['popularity']?.toStringAsFixed(1) ?? "N/A",
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).textTheme.bodyMedium!.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        favNotifier.toggleFavorite(movie);

                        ToastMessage.showToast(
                          isFav
                              ? "Removed from Favorites"
                              : "Added to Favorites",
                          isError: isFav,
                        );
                      },
                      icon: Icon(
                        isFav ? Icons.favorite : Icons.favorite_border,
                        color: Colors.red,
                      ),
                      label: Text(
                        isFav ? "Remove from Favorites" : "Add to Favorites",
                      ),
                    ),

                    const SizedBox(width: 12),

                    ElevatedButton.icon(
                      onPressed: () async {
                        final trailerKey = await TrailerService.fetchTrailer(
                          movie['id'],
                        );
                        if (trailerKey != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  TrailerScreen(videoId: trailerKey),
                            ),
                          );
                        } else {
                          ToastMessage.showToast(
                            "Trailer not available",
                            isError: true,
                          );
                        }
                      },
                      icon: const Icon(Icons.play_arrow),
                      label: const Text("Watch Trailer"),
                    ),

                    const SizedBox(width: 12),

                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CastScreen(movieId: movie['id']),
                          ),
                        );
                      },
                      icon: const Icon(Icons.people),
                      label: const Text("View Cast"),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
