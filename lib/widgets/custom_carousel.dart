import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie_explorer_app/common/utils.dart';
import 'package:movie_explorer_app/models/movies_series.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CustomCarouselSlider extends StatelessWidget {
  final MovieModel data;
  const CustomCarouselSlider({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    // If the movie data is empty, show the 'No Movies' message
    if (data.results.isEmpty) {
      return Center(
        child: Text(
          'No Movies Available at the moment',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
      );
    }

    return SizedBox(
      width: size.width,
      height: (size.height * 0.33 < 300) ? 300 : size.height * 0.33,
      child: CarouselSlider.builder(
        itemCount: data.results.length,
        itemBuilder: (BuildContext context, int index, int realIndex) {
          var url = data.results[index].backdropPath.toString();

          return GestureDetector(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start,
              children: [
                // Cached image with responsive height and width
                CachedNetworkImage(
                  imageUrl: '$imageUrl$url',
                  fit: BoxFit.cover,
                  width: double.infinity, // Full width
                  height: MediaQuery.of(context).size.height *
                      0.25, // Responsive height
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(), // Loading indicator
                  ),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error, // Error icon for failed image loading
                    color: Colors.red,
                  ),
                ),
                const SizedBox(height: 20), // Space between image and text
                // Movie title with emoji
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    '🎬 ${data.results[index].title}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis, // Prevent text overflow
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    '⭐ Rating: ${data.results[index].voteAverage.toStringAsFixed(1)}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    overflow: TextOverflow.ellipsis, // Prevent text overflow
                  ),
                ),
              ],
            ),
          );
        },
        options: CarouselOptions(
          height: (size.height * 0.33 < 300) ? 300 : size.height * 0.33,
          aspectRatio: 16 / 9,
          autoPlay: true,
          initialPage: 0,
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayInterval: const Duration(seconds: 3),
          enlargeCenterPage: true,
          reverse: false,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }
}
