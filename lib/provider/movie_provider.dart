import 'package:flutter/material.dart';
import 'package:movie_explorer_app/models/upcoming_model.dart';
import 'package:movie_explorer_app/services/api_services.dart';
import 'package:movie_explorer_app/models/movies_series.dart';

class MoviesProvider with ChangeNotifier {
  final ApiServices apiServices = ApiServices();

  UpcomingMovieModel? _upcomingMovies;
  UpcomingMovieModel? _nowPlayingMovies;
  MovieModel? _topRatedMovies;
  bool _isLoading = true;
  String _errorMessage = '';

  UpcomingMovieModel? get upcomingMovies => _upcomingMovies;
  UpcomingMovieModel? get nowPlayingMovies => _nowPlayingMovies;
  MovieModel? get topRatedMovies => _topRatedMovies;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  MoviesProvider() {
    fetchMoviesData();
  }

  Future<void> fetchMoviesData() async {
    try {
      _isLoading = true;
      notifyListeners();

      _upcomingMovies = await apiServices.getUpcomingMovies();
      _nowPlayingMovies = await apiServices.getNowPlayingMovies();
      _topRatedMovies = await apiServices.getTopRatedMovies();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Failed to fetch movies: $e';
      notifyListeners();
    }
  }
}