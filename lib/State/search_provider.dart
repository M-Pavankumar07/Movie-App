import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:http/http.dart' as http;
import 'package:movie/utils/apikey.dart';

final searchQueryProvider = StateProvider<String>((ref) => "");
final searchMoviesProvider = FutureProvider<List>((ref) async {
  final query = ref.watch(searchQueryProvider);
  if(query.isEmpty) return [];
  final apikey = Apikey().apikey;
  final response = await http.get(
    Uri.parse('https://api.themoviedb.org/3/search/movie?api_key=$apikey&query=$query'),
  );

  if(response.statusCode == 200){
    final data = json.decode(response.body);
    return data['results'];
  }else{
    throw Exception('Failed to search movies');
  }
});
