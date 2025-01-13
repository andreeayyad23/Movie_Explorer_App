import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:movie_explorer_app/models/search_model.dart';
import 'package:movie_explorer_app/provider/favorite_provider.dart';
import 'package:movie_explorer_app/screens/movie_detailed_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movie_explorer_app/common/utils.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Favorites',
          style: TextStyle(
            color: Colors.white,
            fontSize: 17.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: favoriteProvider.favorites.isEmpty
          ? const Center(
              child: Text(
                'No favorites yet!',
                style: TextStyle(color: Colors.white),
              ),
            )
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio: 1.2 / 2,
              ),
              itemCount: favoriteProvider.favorites.length,
              itemBuilder: (context, index) {
                final movie = favoriteProvider.favorites[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailedScreen(
                          movieId: movie.id,
                        ),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      CachedNetworkImage(
                        imageUrl: "$imageUrl${movie.posterPath}",
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                      Flexible(
                        child: Text(
                          movie.title,
                          style: const TextStyle(
                            fontSize: 17.0,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}