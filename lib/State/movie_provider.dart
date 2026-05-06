import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie/utils/apikey.dart';

final movieProvider = FutureProvider<MovieState>((ref) async {
  final apikey = Apikey().apikey;
  final responses = await Future.wait([
    http.get(
      Uri.parse('https://api.themoviedb.org/3/movie/popular?api_key=$apikey'),
    ),
    http.get(
      Uri.parse('https://api.themoviedb.org/3/movie/top_rated?api_key=$apikey'),
    ),
    http.get(
      Uri.parse('https://api.themoviedb.org/3/movie/now_playing?api_key=$apikey'),
    ),
  ]);

  if(responses.every((res) => res.statusCode == 200)){
    final popular = json.decode(responses[0].body)['results'];
    final topRated = json.decode(responses[1].body)['results'];
    final nowPlaying = json.decode(responses[2].body)['results'];

    return MovieState(
      popular: popular,
      topRated: topRated,
      nowPlaying: nowPlaying,
    );
  } else {
    throw Exception('Failed to load movies');
  }
});


class MovieState {
  final List popular;
  final List topRated;
  final List nowPlaying;

  MovieState({
    required this.popular,
    required this.topRated,
    required this.nowPlaying,
  });
}