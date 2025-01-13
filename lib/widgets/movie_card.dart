import 'package:flutter/material.dart';
import 'package:movie_explorer_app/common/utils.dart';
import 'package:movie_explorer_app/models/upcoming_model.dart';

class MovieCard extends StatelessWidget {
  final UpcomingMovieModel? movies;
  final String headLineText;
  final Function(int) onMovieTap;
  final int crossAxisCount;

  const MovieCard({
    super.key,
    required this.movies,
    required this.headLineText,
    required this.onMovieTap,
    this.crossAxisCount = 3,
  });

  @override
  Widget build(BuildContext context) {
    if (movies == null || movies!.results.isEmpty) {
      return Center(
        child: Text(
          'No Movies Available at the moment!',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            headLineText,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        Expanded(
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 160, // Maximum width per item
              mainAxisSpacing: 8, // Space between items on the main axis
              crossAxisSpacing: 8, // Space between items on the cross axis
              childAspectRatio: 3 / 5, // Aspect ratio of each item
            ),
            itemCount: movies!.results.length,
            itemBuilder: (context, index) {
              final movie = movies!.results[index];
              return GestureDetector(
                onTap: () => onMovieTap(movie.id),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage('$imageUrl${movie.posterPath}'),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
