import 'package:flutter/material.dart';
import 'package:movie_explorer_app/provider/movie_provider.dart';
import 'package:movie_explorer_app/screens/movie_detailed_screen.dart';
import 'package:movie_explorer_app/screens/search_screen.dart';
import 'package:movie_explorer_app/widgets/custom_carousel.dart';
import 'package:movie_explorer_app/widgets/movie_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch movies when the screen is initialized
    Provider.of<MoviesProvider>(context, listen: false).fetchMoviesData();
  }

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(
              Icons.movie,
              size: 28,
              color: Colors.white,
            ),
            const SizedBox(width: 10),
            const Text(
              'Movie Explorer',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.black,
        elevation: 8,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Search Movies',
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchScreen(),
                ),
              );
              print('Search button pressed');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (moviesProvider.topRatedMovies != null)
              CustomCarouselSlider(
                data: moviesProvider.topRatedMovies!,
              ),
            SizedBox(
              height: 220,
              child: MovieCard(
                movies: moviesProvider.nowPlayingMovies,
                headLineText: "Now Playing Movies",
                onMovieTap: (movieId) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MovieDetailedScreen(movieId: movieId),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: 220, // Fixed height for Upcoming Movies
              child: MovieCard(
                movies: moviesProvider.upcomingMovies,
                headLineText: "Upcoming Movies",
                onMovieTap: (movieId) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          MovieDetailedScreen(movieId: movieId),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
