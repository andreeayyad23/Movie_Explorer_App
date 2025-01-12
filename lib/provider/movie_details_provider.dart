import 'package:flutter/material.dart';
import 'package:movie_explorer_app/models/describe_model.dart';
import 'package:movie_explorer_app/services/api_services.dart';

class MovieDetailsProvider with ChangeNotifier {
  final ApiServices _apiServices = ApiServices();

  DescribeModel? _movieDetails;
  bool _isLoading = false;
  bool _hasError = false;

  DescribeModel? get movieDetails => _movieDetails;
  bool get isLoading => _isLoading;
  bool get hasError => _hasError;

  Future<void> fetchMovieDetails(int movieId) async {
    _isLoading = true;
    _hasError = false;
    notifyListeners();

    try {
      _movieDetails = await _apiServices.getMovieDetails(movieId);
      _hasError = false;
    } catch (e) {
      _hasError = true;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}