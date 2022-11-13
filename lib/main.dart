import 'package:flutter/material.dart';
import 'package:movieopedia/utils/text.dart';
import 'package:movieopedia/widgets/topRated.dart';
import 'package:movieopedia/widgets/trending.dart';
import 'package:movieopedia/widgets/tv.dart';
import 'package:tmdb_api/tmdb_api.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Home(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.light().copyWith(primary: Colors.indigo),
        ));
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List trendingMovies = [];
  List topRatedMovies = [];
  List tv = [];
  final String apiKey = 'f30b3bd63c697a313d3484e4c5c7bd95';
  final String readAccessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmMzBiM2JkNjNjNjk3YTMxM2QzNDg0ZTRjNWM3YmQ5NSIsInN1YiI6IjVmN2UyMDk2ZjkwYjE5MDAzNWM4YmRmNyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.imL6nk0ZihneH18R9QE40lLKjz7dzFpOZXGEZmMKN-I';

  @override
  void initState() {
    loadMovies();
    super.initState();
  }

  loadMovies() async {
    TMDB tmdbWithCustomLogs = TMDB(ApiKeys(apiKey, readAccessToken),
        logConfig: ConfigLogger(showLogs: true, showErrorLogs: true));

    Map trendingResults = await tmdbWithCustomLogs.v3.trending.getTrending();
    Map topRatedResults = await tmdbWithCustomLogs.v3.movies.getTopRated();
    Map tvResults = await tmdbWithCustomLogs.v3.tv.getPopular();
    print(trendingResults);
    setState(() {
      trendingMovies = trendingResults['results'];
      topRatedMovies = topRatedResults['results'];
      tv = tvResults['results'];
    });
    print(trendingMovies);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: ModifiedText(
            text: 'movieopedia',
            color: Colors.white,
            size: 24,
          ),
        ),
        body: ListView(
          children: [
            TrendingMovies(trending: trendingMovies),
            TopRated(topRated: topRatedMovies),
            TV(tv: tv),
          ],
        ));
  }
}
