import 'dart:convert';
import 'dart:developer';

import 'package:movie_explorer_app/common/utils.dart';
import 'package:movie_explorer_app/models/describe_model.dart';
import 'package:movie_explorer_app/models/movies_series.dart';
import 'package:movie_explorer_app/models/search_model.dart';
import 'package:movie_explorer_app/models/upcoming_model.dart';
import 'package:http/http.dart' as http;

const String baseUrl = 'https://api.themoviedb.org/3/';
var key = "?api_key=$apikey";
late String endpoint;

class ApiServices {
  Future<UpcomingMovieModel> getUpcomingMovies() async {
    endpoint = "movie/upcoming";
    final url = "$baseUrl$endpoint$key";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      log("Success");
      return UpcomingMovieModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('Failed to load upcoming movies!');
  }

  Future<UpcomingMovieModel> getNowPlayingMovies() async {
    endpoint = "movie/now_playing";
    final url = "$baseUrl$endpoint$key";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      log("Success");
      return UpcomingMovieModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('Failed to load now playing movies');
  }

  Future<MovieModel> getTopRatedMovies() async {
    endpoint = "movie/top_rated";
    final url = "$baseUrl$endpoint$key";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      log("Success");
      return MovieModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('Failed to load top rated movies');
  }

  Future<SearchModel> getSearchMovies(String searchText) async {
    endpoint = "search/movie?query=$searchText";
    final url = "$baseUrl$endpoint";
    print("search url $url");

    final response = await http.get(Uri.parse(url), headers: {
      'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxYjg4YTZhMWYwM2E5YzY5NWFjMTQzY2FlNDJiZDkyYiIsIm5iZiI6MTczNDk1NTUxMS4xMTksInN1YiI6IjY3Njk1MWY3NTdmNmE2N2M4NTVjZTkxNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.ujXY6aUQSojkU5t_PGPeTF1x2D1S8c-WJH3wy_UImMw'});

    if (response.statusCode == 200) {
      log("Success");
      return SearchModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('Failed to load search movies');
  }

   Future<DescribeModel> getMovieDetails(int movieId) async {
    endpoint = "movie/$movieId";
    final url = "$baseUrl$endpoint$key";
    print("search url $url");

    final response = await http.get(Uri.parse(url),);

    if (response.statusCode == 200) {
      log("Success");
      return DescribeModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('Failed to load Describe movies');
  }
}
