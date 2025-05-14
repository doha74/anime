import 'package:flutter/material.dart';
import 'package:game_buzz/provider/favorites_provider.dart';
import 'package:provider/provider.dart';
import 'movie.dart';

class MovieDetailScreen extends StatefulWidget {
  final Movie movie;

  // Receive the movie data from the main screen
  const MovieDetailScreen({super.key, required this.movie});

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
   // Track favorite status


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.movie.title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: Icon(
              context.watch<FavoritesProvider>().isFavorite(widget.movie.id)
                  ? Icons.favorite
                  : Icons.favorite_border,
            ),
            onPressed: () {
              final provider = context.read<FavoritesProvider>();
              if (provider.isFavorite(widget.movie.id)) {
                provider.removeFavorite(widget.movie.id);
              } else {
                provider.addFavorite(widget.movie); // must be the same structure!
              }
            },

          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Movie poster with rounded corners
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                'https://image.tmdb.org/t/p/w342${widget.movie.posterPath}',
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),

            // Movie title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                widget.movie.title,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Movie release date
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Release Date: ${widget.movie.releaseDate}',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 8),

            // Movie vote average
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                '⭐ ${widget.movie.voteAverage}',
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 8),

            // Movie vote count
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Votes: ${widget.movie.voteCount}',
                style: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 16),

            // Movie overview
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                widget.movie.overview,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
