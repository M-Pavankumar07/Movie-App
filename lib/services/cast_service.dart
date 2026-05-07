import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie/utils/apikey.dart';

class CastService {
  static final apikey = Apikey().apikey;

  static Future<List> fetchCast(int movieId) async {
    final url = 'https://api.themoviedb.org/3/movie/$movieId/credits?api_key=$apikey';
    final response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      return data['cast'];
    }
    return [];
  }
}