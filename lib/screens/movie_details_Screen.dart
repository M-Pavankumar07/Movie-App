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
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                movie['overview'] ?? "",
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyMedium!.color,
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 20),

              ElevatedButton.icon(
                onPressed: () {
                  favNotifier.toggleFavorite(movie);

                  ToastMessage.showToast(
                    isFav ? "Removed from Favorites" : "Added to Favorites",
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

              ElevatedButton.icon(
                onPressed: () async {
                  final trailerKey = await TrailerService.fetchTrailer(movie['id']);
                  if (trailerKey != null){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TrailerScreen(videoId: trailerKey)),
                    );
                  }else{
                    ToastMessage.showToast("Trailer not available", isError: true);
                  }
                },
                icon: const Icon(Icons.play_arrow),
                label: const Text("Watch Trailer"),
              ),

              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CastScreen(movieId: movie['id'])),
                  );
                },
                icon: const Icon(Icons.people),
                label: const Text("View Cast"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
