import 'package:flutter/material.dart';
import 'package:movie_explorer_app/common/utils.dart';
import 'package:movie_explorer_app/models/describe_model.dart';
import 'package:movie_explorer_app/screens/homescreen.dart';
import 'package:provider/provider.dart';
import 'package:movie_explorer_app/provider/movie_details_provider.dart';

class MovieDetailedScreen extends StatefulWidget {
  final int movieId;
  const MovieDetailedScreen({super.key, required this.movieId});

  @override
  State<MovieDetailedScreen> createState() => _MovieDetailedScreenState();
}

class _MovieDetailedScreenState extends State<MovieDetailedScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch movie details when the screen is initialized
    Provider.of<MovieDetailsProvider>(context, listen: false)
        .fetchMovieDetails(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    final movieDetailsProvider = Provider.of<MovieDetailsProvider>(context);

    return Scaffold(
      body: movieDetailsProvider.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : movieDetailsProvider.hasError ||
                  movieDetailsProvider.movieDetails == null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "No Results Found. Redirecting...",
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          );
                        },
                        child: const Text('Go Back'),
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Poster Image with Back Button
                      Stack(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.4,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    "$imageUrl${movieDetailsProvider.movieDetails!.backdropPath}"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 40,
                            left: 10,
                            child: IconButton(
                              icon: const Icon(Icons.arrow_back_ios_new,
                                  color: Color.fromARGB(255, 255, 185, 185)),
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomeScreen()),
                                  (route) =>
                                      false, // Removes all previous routes
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      // Title
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          movieDetailsProvider.movieDetails!.title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // Overview/Description
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          movieDetailsProvider.movieDetails!.overview,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Release Date
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            const Icon(Icons.calendar_today,
                                size: 18, color: Colors.grey),
                            const SizedBox(width: 8),
                            Text(
                              "Release Date: ${movieDetailsProvider.movieDetails!.releaseDate}",
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Rating
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            const Icon(Icons.star,
                                size: 18, color: Colors.amber),
                            const SizedBox(width: 8),
                            Text(
                              "Rating: ${movieDetailsProvider.movieDetails!.voteAverage.toString()} / 10",
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
    );
  }
}
