import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_explorer_app/common/utils.dart';
import 'package:movie_explorer_app/models/search_model.dart';
import 'package:movie_explorer_app/screens/movie_detailed_screen.dart';
import 'package:provider/provider.dart';
import 'package:movie_explorer_app/provider/search_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);

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
              fontSize: 17.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 5.0),
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
                  searchProvider.search(value);
                },
              ),
              Expanded(
                child: searchProvider.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : searchProvider.hasError
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
                                    searchProvider
                                        .search(searchController.text);
                                  },
                                  child: const Text('Retry'),
                                ),
                              ],
                            ),
                          )
                        : (searchProvider.searchModel == null ||
                                searchProvider.searchModel!.results.isEmpty)
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
                                itemCount: searchProvider
                                        .searchModel?.results.length ??
                                    0,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      if (searchProvider.hasError) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'Failed to load details. Please try again later.'),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      } else {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                MovieDetailedScreen(
                                              movieId: searchProvider
                                                  .searchModel!
                                                  .results[index]
                                                  .id,
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    child: Column(
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl:
                                              "$imageUrl${searchProvider.searchModel!.results[index].posterPath}",
                                          placeholder: (context, url) =>
                                              const CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error),
                                        ),
                                        Flexible(
                                          child: Text(
                                            searchProvider.searchModel!
                                                .results[index].title,
                                            style: const TextStyle(
                                              fontSize: 17.0,
                                              color: Colors.white,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
