import 'package:flutter/material.dart';
import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:movie/screens/movie_details_Screen.dart';

class BannerWidget extends StatelessWidget {
  final List movies;

  const BannerWidget({super.key, required this.movies});

  String getImageUrl(String? path) {
    if (path == null || path.isEmpty) {
      return "";
    }
    return "https://image.tmdb.org/t/p/w500$path";
  }

  @override
  Widget build(BuildContext context) {
    final bannerMovies = movies.take(5).toList();

    return CarouselSlider(
      options: CarouselOptions(
        height: 350,
        autoPlay: true,
        viewportFraction: 1,
        enlargeCenterPage: false,
      ),
      items: bannerMovies.map((movie) {
        return Stack(
          fit: StackFit.expand,
          children: [

            movie['backdrop_path'] != null &&
                    movie['backdrop_path'].toString().isNotEmpty
                ? Image.network(
                    getImageUrl(movie['backdrop_path']),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(color: Colors.black);
                    },
                  )
                : Container(color: Colors.black),

            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black87, Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),

            Positioned(
              bottom: 20,
              left: 12,
              right: 12,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    movie['title'] ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          blurRadius: 10,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.yellow),
                      const SizedBox(width: 5),
                      Text(
                        movie['vote_average']?.toString() ?? "0",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  Row(
                    children: [
                      ElevatedButton( 
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  MovieDetailsScreen(movie: movie),
                            ),
                          );
                        },
                        child: const Text("Play"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        );
      }).toList(),
    );
  }
}