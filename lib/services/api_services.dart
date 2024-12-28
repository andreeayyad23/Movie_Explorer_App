import 'dart:convert';
import 'dart:developer';

import 'package:movie_explorer_app/models/describe_model.dart';
import 'package:movie_explorer_app/models/movies_series.dart';
import 'package:movie_explorer_app/models/search_model.dart';
import 'package:movie_explorer_app/models/upcoming_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

const String baseUrl = 'https://api.themoviedb.org/3/';

class ApiServices {
  final String apiKey = dotenv.env['API_KEY']!; // Securely load the API key
  late String endpoint;

  // Fetch upcoming movies
  Future<UpcomingMovieModel> getUpcomingMovies() async {
    endpoint = "movie/upcoming";
    final url = "$baseUrl$endpoint?api_key=$apiKey";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      log("Success");
      return UpcomingMovieModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('Failed to load upcoming movies!');
  }

  // Fetch now playing movies
  Future<UpcomingMovieModel> getNowPlayingMovies() async {
    endpoint = "movie/now_playing";
    final url = "$baseUrl$endpoint?api_key=$apiKey";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      log("Success");
      return UpcomingMovieModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('Failed to load now playing movies');
  }

  // Fetch top-rated movies
  Future<MovieModel> getTopRatedMovies() async {
    endpoint = "movie/top_rated";
    final url = "$baseUrl$endpoint?api_key=$apiKey";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      log("Success");
      return MovieModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('Failed to load top rated movies');
  }

  // Search movies by text
  Future<SearchModel> getSearchMovies(String searchText) async {
    endpoint = "search/movie?query=$searchText";
    final url = "$baseUrl$endpoint&api_key=$apiKey";
    print("search url $url");

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      log("Success");
      return SearchModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('Failed to load search movies');
  }

  // Fetch movie details by movie ID
  Future<DescribeModel> getMovieDetails(int movieId) async {
    endpoint = "movie/$movieId";
    final url = "$baseUrl$endpoint?api_key=$apiKey";
    print("search url $url");

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      log("Success");
      return DescribeModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('Failed to load movie details');
  }
}
