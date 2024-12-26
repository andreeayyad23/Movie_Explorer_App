import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_explorer_app/common/utils.dart';
import 'package:movie_explorer_app/models/search_model.dart';
import 'package:movie_explorer_app/screens/movie_detailed_screen.dart';
import 'package:movie_explorer_app/services/api_services.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  ApiServices apiServices = ApiServices();

  SearchModel? searchModel;
  bool hasError = false; // Track error state

  void search(String query) {
    setState(() {
      hasError = false; // Reset error state before making a new request
    });

    apiServices.getSearchMovies(query).then((results) {
      setState(() {
        searchModel = results;
        hasError = false; // Reset error state on successful fetch
      });
    }).catchError((error) {
      setState(() {
        hasError = true; // Set error state on failure
      });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          ),
          title: const Text(
            'Search Movies',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.0, // Fixed font size
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 5.0), // Add 5px margin at the top
          child: Column(
            children: [
              CupertinoSearchTextField(
                padding: const EdgeInsets.all(10),
                controller: searchController,
                prefixIcon: const Icon(
                  CupertinoIcons.search,
                  color: Colors.grey,
                ),
                suffixIcon: const Icon(
                  Icons.cancel,
                  color: Colors.grey,
                ),
                style: const TextStyle(color: Colors.white),
                backgroundColor: Colors.grey.withOpacity(0.3),
                onChanged: (value) {
                  if (value.isEmpty) {
                    setState(() {
                      searchModel =
                          null; // Reset search results if query is empty
                    });
                  } else {
                    search(value); // Use the current value directly
                  }
                },
              ),
              Expanded(
                child: hasError
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Failed to load results. Please try again.',
                              style: TextStyle(color: Colors.white),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                search(searchController.text);
                              },
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      )
                    : (searchModel == null || searchModel!.results.isEmpty
                        ? const Center(
                            child: Text(
                              'No results found',
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        : GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 15,
                              crossAxisSpacing: 15,
                              childAspectRatio: 1.2 / 2,
                            ),
                            itemCount: searchModel?.results.length ?? 0,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MovieDetailedScreen(
                                        movieId: searchModel!.results[index].id,
                                      ),
                                    ),
                                  );
                                },
                                child: Column(
                                  children: [
                                    CachedNetworkImage(
                                      imageUrl:
                                          "$imageUrl${searchModel!.results[index].posterPath}",
                                      placeholder: (context, url) =>
                                          const CircularProgressIndicator(),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                    Flexible(
                                      child: Text(
                                        searchModel!.results[index].title,
                                        style: TextStyle(
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.04,
                                          color: Colors
                                              .white,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
