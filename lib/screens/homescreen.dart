import 'package:flutter/material.dart';
import 'package:movie_explorer_app/models/movies_series.dart';
import 'package:movie_explorer_app/models/upcoming_model.dart';
import 'package:movie_explorer_app/screens/movie_detailed_screen.dart';
import 'package:movie_explorer_app/screens/search_screen.dart';
import 'package:movie_explorer_app/services/api_services.dart';
import 'package:movie_explorer_app/widgets/custom_carousel.dart';
import 'package:movie_explorer_app/widgets/movie_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<UpcomingMovieModel> upcomingFuture;
  // ignore: non_constant_identifier_names
  late Future<UpcomingMovieModel> NowplayingFuture;
  late Future<MovieModel> topRatedMovies;

  ApiServices apiServices = ApiServices();
  @override
  void initState() {
    super.initState();
    upcomingFuture = apiServices.getUpcomingMovies();
    NowplayingFuture = apiServices.getNowPlayingMovies();
    topRatedMovies = apiServices.getTopRatedMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(
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
            FutureBuilder(
              future: topRatedMovies,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return CustomCarouselSlider(
                    data: snapshot.data!,
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
            SizedBox(
              height: 220,
              child: MovieCard(
                future: NowplayingFuture,
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
              height: 220,
              child: MovieCard(
                future: upcomingFuture,
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
