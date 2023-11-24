import 'package:cinema/widget/card_Home.dart';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:tmdb_api/tmdb_api.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map movipopular = {};
  Map movieLast = {};
  Map movieNow = {};
  Map movieUpcom = {};
  Map trending = {};

  //tv
  Map tvOnair = {};
  Map tvPop = {};
  Map tvTop = {};
  Map tvTrend = {};

  List<bool> isSelected = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  @override
  void initState() {
    info();
    super.initState();
  }

  String apikey = "cf3e00ea296dc09f246e77b036845049";
  String readaccesstoken =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjZjNlMDBlYTI5NmRjMDlmMjQ2ZTc3YjAzNjg0NTA0OSIsInN1YiI6IjY1NGU1N2E1ZDQ2NTM3MDBhYjk1MWU4NyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.qPLTdMHqloyXvRf9QWKmH__NrlHNZmJZUziWkXJKo00";

  info() async {
    String apikey = "cf3e00ea296dc09f246e77b036845049";
    String readaccesstoken =
        "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjZjNlMDBlYTI5NmRjMDlmMjQ2ZTc3YjAzNjg0NTA0OSIsInN1YiI6IjY1NGU1N2E1ZDQ2NTM3MDBhYjk1MWU4NyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.qPLTdMHqloyXvRf9QWKmH__NrlHNZmJZUziWkXJKo00";
    TMDB tmdbWithCustomLogs = TMDB(
      ApiKeys(apikey, readaccesstoken),
      logConfig: const ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );

    try {
      Map moviePopular = await tmdbWithCustomLogs.v3.movies.getPopular();
      Map movieToprate = await tmdbWithCustomLogs.v3.movies.getTopRated();
      Map movieUp = await tmdbWithCustomLogs.v3.movies.getUpcoming();
      Map movieNowPlaying = await tmdbWithCustomLogs.v3.movies.getNowPlaying();
      Map trendingw = await tmdbWithCustomLogs.v3.trending
          .getTrending(mediaType: MediaType.movie);

      // Map tvLast2 = await tmdbWithCustomLogs.v3.tv.getLatest();
      Map tvOnAir = await tmdbWithCustomLogs.v3.tv.getOnTheAir();
      Map tvPopuler = await tmdbWithCustomLogs.v3.tv.getPopular();
      Map tvTop2 = await tmdbWithCustomLogs.v3.tv.getTopRated();
      Map tvTre = await tmdbWithCustomLogs.v3.trending
          .getTrending(mediaType: MediaType.tv);
      setState(() {
        movipopular = moviePopular;
        movieLast = movieToprate;
        movieUpcom = movieUp;
        movieNow = movieNowPlaying;
        trending = trendingw;
        tvOnair = tvOnAir;
        tvPop = tvPopuler;
        tvTop = tvTop2;
        tvTrend = tvTre;
        // print(tvPop);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // final moviePopw = watch(counterStatProvider);

    if (movipopular.isEmpty &&
        movieLast.isEmpty &&
        movieNow.isEmpty &&
        movieUpcom.isEmpty &&
        trending.isEmpty &&
        tvOnair.isEmpty &&
        tvPop.isEmpty &&
        tvTop.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    // print("$moviePopw  ");
    return Scaffold(
      // backgroundColor: Colors.transparent,
      body: DefaultTabController(
        length: 3,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              // leading: Text("S L IV E R "),
              expandedHeight: 300,
              floating: false,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  children: [
                    AnimatedOpacity(
                      duration: const Duration(seconds: 3),
                      opacity: 1.0,
                      child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          alignment: Alignment.bottomLeft,
                          padding: const EdgeInsets.only(
                              top: 30, left: 20, right: 20, bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  "EXPLORE \nCOLLECTIONS",
                                  style: GoogleFonts.poppins(
                                      height: 0.9,
                                      fontSize: 40,
                                      fontWeight: FontWeight.w900,
                                      color: const Color.fromARGB(
                                          255, 37, 21, 11)),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: GestureDetector(
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    padding: const EdgeInsets.all(6),
                                    margin: const EdgeInsets.only(top: 30),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            240, 255, 114, 7),
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: const Icon(
                                      Icons.favorite_outline,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                title: const Text(""),
              ),
            ),

            // heading of movies

            SliverToBoxAdapter(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  // border: Border.all(
                  //     color: const Color.fromARGB(239, 175, 175, 175),
                  //     width: 1),
                ),
                child: const Text(
                  "Movies ",
                  style: TextStyle(
                    color: Color.fromARGB(240, 255, 114, 7),
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
                child: CardHome(
              movie: movipopular,
              heading: "Popular\n Movie",
              index: 0,
              content: "original_title",
              size: 35,
              isbool: false,
            )),
            SliverToBoxAdapter(
                child: CardHome(
              movie: movieLast,
              heading: "Lastest\n Movie",
              index: 1,
              size: 40,
              content: "original_title",
              isbool: false,
            )),
            SliverToBoxAdapter(
                child: CardHome(
              movie: movieUpcom,
              heading: "Upcomm-\ning Movie",
              index: 2,
              size: 29,
              content: "original_title",
              isbool: false,
            )),
            SliverToBoxAdapter(
                child: CardHome(
              movie: movieNow,
              heading: "Now \nAvailable\n movies",
              index: 2,
              size: 30,
              content: "original_title",
              isbool: false,
            )),
            SliverToBoxAdapter(
                child: CardHome(
              movie: trending,
              heading: "Trending \nMovies",
              index: 3,
              size: 30,
              content: "original_title",
              isbool: false,
            )),

            //heading od series and showes

            SliverToBoxAdapter(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: Color.fromARGB(239, 175, 175, 175), width: 1),
                ),
                child: Text(
                  "Series",
                  style: TextStyle(
                    color: Color.fromARGB(240, 255, 114, 7),
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
                child: CardHome(
              movie: tvTrend,
              heading: "Trending\nMovies",
              index: 6,
              content: "original_name",
              size: 32,
              isbool: true,
            )),

            SliverToBoxAdapter(
                child: CardHome(
              movie: tvOnair,
              heading: "Lastest \n shows",
              index: 4,
              size: 40,
              content: "original_name",
              isbool: true,
            )),
            SliverToBoxAdapter(
                child: CardHome(
              movie: tvPop,
              heading: "shows \n OnAir \n now ",
              index: 5,
              content: "original_name",
              size: 40,
              isbool: true,
            )),
            SliverToBoxAdapter(
                child: CardHome(
              movie: tvTop,
              heading: "Top \nWatches \nnow ",
              index: 6,
              content: "original_name",
              size: 32,
              isbool: true,
            )),
          ],
        ),
      ),
    );
  }
}
