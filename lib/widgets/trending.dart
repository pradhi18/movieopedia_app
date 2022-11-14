import 'package:flutter/material.dart';
import 'package:movieopedia/details.dart';
import 'package:movieopedia/utils/text.dart';

// Trending movies widget
class TrendingMovies extends StatelessWidget {
  final List trending;

  const TrendingMovies({super.key, required this.trending});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ModifiedText(
            text: 'Trending Movies',
            color: Colors.white,
            size: 20,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 270,
            child: ListView.builder(
                itemCount: trending.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: ((context, index) {
                  return InkWell(
                    // Using the Navigator API to navigate to 2nd screen
                    // to get details of a particular trending movie
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Details(
                                  name: trending[index]['title'],
                                  desc: trending[index]['overview'],
                                  bannerurl: 'https://image.tmdb.org/t/p/w500' +
                                      trending[index]['backdrop_path'],
                                  posterurl: 'https://image.tmdb.org/t/p/w500' +
                                      trending[index]['poster_path'],
                                  vote: trending[index]['vote_average']
                                      .toString(),
                                  launch_on: trending[index]['release_date'])));
                    },
                    child: trending[index]['title'] != null
                        ? Container(
                            width: 140,
                            child: Column(
                              children: [
                                Container(
                                  height: 200,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              'https://image.tmdb.org/t/p/w500' +
                                                  trending[index]
                                                      ['poster_path']))),
                                ),
                                Container(
                                  child: ModifiedText(
                                    text: trending[index]['title'] != null
                                        ? trending[index]['title']
                                        : 'Loading',
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                )
                              ],
                            ))
                        : Container(),
                  );
                })),
          )
        ],
      ),
    );
  }
}
