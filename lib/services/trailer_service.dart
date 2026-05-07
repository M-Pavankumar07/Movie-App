import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie/utils/apikey.dart';

class TrailerService {
  static final apikey = Apikey().apikey;

  static Future<String?> fetchTrailer(int movieId) async {
    final url =
        'https://api.themoviedb.org/3/movie/$movieId/videos?api_key=$apikey';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final results = data['results'];
      for (var video in results){
        if(video['site'] == 'YouTube' && video['type'] == 'Trailer'){
          return video['key'];
        }
      }
    } 

    return null;
  }
}
