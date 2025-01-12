import 'package:flutter/material.dart';
import 'package:movie_explorer_app/models/search_model.dart';
import 'package:movie_explorer_app/services/api_services.dart';

class SearchProvider with ChangeNotifier {
  final ApiServices _apiServices = ApiServices();

  SearchModel? _searchModel;
  bool _hasError = false;
  bool _isLoading = false;

  SearchModel? get searchModel => _searchModel;
  bool get hasError => _hasError;
  bool get isLoading => _isLoading;

  Future<void> search(String query) async {
    if (query.isEmpty) {
      _searchModel = null;
      notifyListeners();
      return;
    }

    _isLoading = true;
    _hasError = false;
    notifyListeners();

    try {
      _searchModel = await _apiServices.getSearchMovies(query);
      _hasError = false;
    } catch (e) {
      _hasError = true;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}