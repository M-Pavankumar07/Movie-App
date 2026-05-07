import 'package:flutter/material.dart';
import 'package:movie/services/cast_service.dart';

class CastScreen extends StatefulWidget {
  final int movieId;
  const CastScreen({super.key, required this.movieId});

  @override
  State<CastScreen> createState() => _CastScreenState();
}

class _CastScreenState extends State<CastScreen> {
  List cast = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadCast();
  }

  Future<void> loadCast() async {
    final result = await CastService.fetchCast(widget.movieId);

    setState(() {
      cast = result;
      isLoading = false;
    });
  }

  String getImageUrl(String? path) {
    if (path == null || path.isEmpty) {
      return 'https://via.placeholder.com/150';
    } else {
      return 'https://image.tmdb.org/t/p/w500$path';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(title: Text('Movie Cast')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: cast.length,
              itemBuilder: (context, index) {
                final actor = cast[index];
                return ListTile(
                  leading: CircleAvatar(
                    radius: 28,
                    backgroundImage: actor['profile_path'] != null
                        ? NetworkImage(getImageUrl(actor['profile_path']))
                        : null,
                    child: actor['profile_path'] == null
                        ? const Icon(Icons.person, size: 28)
                        : null,
                  ),

                  title: Text(
                    actor['name'] ?? "",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),

                  subtitle: Text(
                    actor['character'] ?? "",
                    style: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                );
              },
            ),
    );
  }
}
