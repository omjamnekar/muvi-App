import 'dart:ffi';
import 'dart:ui';

import 'package:cinema/Service/content_List_View.dart';
import 'package:cinema/Service/fullFrame.dart';
import 'package:cinema/provider/get.dart';
import 'package:cinema/provider/riv.dart';
import 'package:cinema/widget/partsDetail/commpany.dart';
import 'package:cinema/widget/partsDetail/icon_Work.dart';
import 'package:cinema/widget/partsDetail/movi_Content.dart';
import 'package:cinema/widget/partsDetail/movie_Info.dart';
import 'package:cinema/widget/partsDetail/people_Card.dart';
import 'package:cinema/widget/partsDetail/rating_work.dart';
import 'package:cinema/widget/partsDetail/recommend.dart';
import 'package:cinema/widget/partsDetail/similar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ContentDisplay extends ConsumerStatefulWidget {
  ContentDisplay({super.key, required this.contentId, required this.isTvMovie});

  int contentId;
  bool isTvMovie;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ContentDisplayState();
}

class _ContentDisplayState extends ConsumerState<ContentDisplay> {
  Map contentMap = {};
  Map contentCast = {};

  @override
  Widget build(BuildContext context) {
    print(widget.contentId);

    var screenSize = MediaQuery.of(context).size;
    final int id = widget.contentId;

    final contentDetailM = ref.watch(movieDetailSp(id));
    final castMovie = ref.watch(movieCast(id));

    final contentDetaiT = ref.watch(tvDetailSp(id));
    final tvCaste = ref.watch(tvCast(id));
    if (widget.isTvMovie == true) {
      contentMap = contentDetaiT.when(
        data: (data) => data ?? {},
        loading: () => {},
        error: (error, stack) => {},
      );
      contentCast = tvCaste.when(
        /// the cast of movie is remaining
        data: (data) => data ?? {},
        loading: () => {},
        error: (error, stack) => {},
      );
    } else {
      contentMap = contentDetailM.when(
        data: (data) => data ?? {},
        loading: () => {},
        error: (error, stack) => {},
      );

      contentCast = castMovie.when(
        /// the cast of movie is remaining
        data: (data) => data ?? {},
        loading: () => {},
        error: (error, stack) => {},
      );
    }

    double doublenum =
        (contentMap["vote_average"] != null ? contentMap["vote_average"] : 2) /
            10;
    // 0.2
    double singleDig = doublenum * 10;

    int singlepoint = singleDig.toInt();
    double doublepoint = singleDig / 10;
    // if (contentDetailM is AsyncLoading || contentDetaiT is AsyncLoading) {
    //   // If data is still loading, display circular indicator
    //   return const Center(
    //     child: CircularProgressIndicator(),
    //   );
    // }

    if (contentMap.isEmpty) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: CircularProgressIndicator()),
      );
    }
    String image = contentMap["poster_path"];
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 250, 236, 225),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: double.maxFinite,
                  height: 450,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                            "https://image.tmdb.org/t/p/w500${contentMap["poster_path"]}"),
                        fit: BoxFit.cover),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color.fromARGB(255, 255, 1, 1).withOpacity(1),
                        Colors.black.withOpacity(1),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.maxFinite,
                  height: 520,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color.fromARGB(99, 0, 0, 0).withOpacity(0.9),
                        const Color.fromARGB(99, 0, 0, 0).withOpacity(0.7),
                        const Color.fromARGB(99, 0, 0, 0).withOpacity(0.6),
                        Color.fromARGB(26, 32, 32, 32).withOpacity(0.2),
                        const Color.fromARGB(255, 255, 245, 237)
                            .withOpacity(0.2),
                        const Color.fromARGB(255, 255, 245, 237)
                            .withOpacity(0.5),
                        const Color.fromARGB(255, 255, 245, 237)
                            .withOpacity(0.77),
                        const Color.fromARGB(255, 255, 245, 237).withOpacity(1),
                        const Color.fromARGB(255, 255, 245, 237).withOpacity(1),
                      ],
                    ),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                    child: Container(
                      color: Color.fromARGB(11, 0, 0, 0),
                      height: 540,
                      child: Center(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 80,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => FullFrame(
                                          image: image,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Hero(
                                    tag: "object",
                                    child: Container(
                                      width: 170,
                                      height: 500,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(contentMap[
                                                      "poster_path"] !=
                                                  null
                                              ? "https://image.tmdb.org/t/p/w500${contentMap["poster_path"]}"
                                              : "https://t3.ftcdn.net/jpg/00/86/56/12/360_F_86561234_8HJdzg2iBlPap18K38mbyetKfdw1oNrm.jpg"),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  // padding: const EdgeInsets.all(10),
                                  // decoration:
                                  // BoxDecoration(color: Color.fromARGB(31, 0, 0, 0)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 200,
                                        child: Text(
                                          contentMap["title"] != null
                                              ? "${contentMap["title"]}"
                                              : "${contentMap["name"]}",
                                          maxLines: 5,
                                          style: GoogleFonts.poppins(
                                              color: Color.fromARGB(
                                                  255, 34, 34, 34),
                                              fontSize: 25,
                                              height: 1.1,
                                              fontWeight: FontWeight.w800),
                                        ),
                                      ),
                                      // Container(
                                      //   width: 160,
                                      //   child: Text(
                                      //     contentMap["tagline"] != null
                                      //         ? "${contentMap["tagline"]}"
                                      //         : "------",
                                      //     maxLines: 3,
                                      //     style: GoogleFonts.poppins(
                                      //         color: Color.fromARGB(
                                      //             255, 132, 62, 0),
                                      //         fontSize: 17,
                                      //         height: 1,
                                      //         fontWeight: FontWeight.w800),
                                      //   ),
                                      // ),
                                      Gap(10),
                                      Container(
                                        width: 200,
                                        child: (contentMap["genres"] != null &&
                                                contentMap["genres"].isNotEmpty)
                                            ? Text(
                                                "${contentMap["genres"].map((genre) => genre["name"]).join(', ')}",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 222, 100, 7),
                                                ),
                                              )
                                            : Text("------"),
                                      ),
                                      Gap(20),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: 60,
                                              height: 60,
                                              // padding: EdgeInsets.all(20),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  border: Border.all(
                                                    color: Color.fromARGB(
                                                        255, 155, 67, 0),
                                                  )),
                                              child: Center(
                                                child: Text(
                                                  contentMap["runtime"] != null
                                                      ? "${contentMap["runtime"]}\nmin"
                                                      : "------",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      height: 0.8,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromARGB(
                                                          181, 44, 58, 64)),
                                                ),
                                              ),
                                            ),
                                            Gap(10),
                                            Container(
                                              width: 60,
                                              height: 60,
                                              // padding: EdgeInsets.all(20),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  border: Border.all(
                                                    color: Color.fromARGB(
                                                        255, 155, 67, 0),
                                                  )),
                                              child: Center(
                                                child: Text(
                                                  contentMap["original_language"] !=
                                                          null
                                                      ? "${contentMap["original_language"]}\nlang."
                                                      : "------",
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      height: 0.8,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          const Color.fromARGB(
                                                              255, 44, 58, 64)),
                                                ),
                                              ),
                                            ),
                                            Gap(10),
                                            Container(
                                              width: 60,
                                              height: 60,
                                              // padding: EdgeInsets.all(20),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  border: Border.all(
                                                    color: const Color.fromARGB(
                                                        255, 155, 67, 0),
                                                  )),
                                              child: Center(
                                                child: Text(
                                                  contentMap["vote_count"] !=
                                                          null
                                                      ? "${contentMap["vote_count"]}\nvote"
                                                      : "------",
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      height: 0.8,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          const Color.fromARGB(
                                                              255, 44, 58, 64)),
                                                ),
                                              ),
                                            )
                                          ]),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 420,
                  child: Row(
                    children: [
                      Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  width: 2,
                                  color: Color.fromARGB(146, 255, 94, 0))),
                          child: Align(
                            child: Text(
                              contentMap["vote_average"] != null
                                  ? "${contentMap["vote_average"]}\n Avg.Vote"
                                  : "------",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 20,
                                  height: 1,
                                  fontWeight: FontWeight.bold,
                                  color: const Color.fromARGB(255, 44, 58, 64)),
                            ),
                          )),
                      Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 4),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(146, 255, 94, 0),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  width: 2,
                                  color: Color.fromARGB(146, 255, 94, 0))),
                          child: Align(
                              child: Icon(
                            Icons.play_arrow_rounded,
                            color: Color.fromARGB(146, 255, 255, 255),
                            size: 50,
                          ))),
                      Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  width: 2,
                                  color: Color.fromARGB(146, 255, 94, 0))),
                          child: Align(
                            child: Text(
                              contentMap["vote_average"] != null
                                  ? "${contentMap["vote_average"]}\n Avg.Vote"
                                  : "------",
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 20,
                                  height: 1,
                                  fontWeight: FontWeight.bold,
                                  color: const Color.fromARGB(255, 44, 58, 64)),
                            ),
                          )),
                    ],
                  ),
                ),
                Column(
                  children: [
                    SafeArea(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Row(
                          children: [
                            // Container(
                            //     width: 50,
                            //     height: 50,
                            //     decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(50),
                            //       color: Color.fromARGB(255, 255, 245, 237),
                            //       image: DecorationImage(
                            //         image: AssetImage(
                            //           "assets/image/we.png",
                            //         ),
                            //       ),
                            //     )),
                            Spacer(),
                            Icon(Icons.dehaze_outlined, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 300,
                      width: 300,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage("contentMap[]"))),
                    ),
                    // Text(
                    //   "${contentMap["id"]}",
                    //   style:
                    //       TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    // ),
                  ],
                ),
              ],
            ),

            Gap(10),
            Commpany(detailMovie: contentMap),

            MovieContent(detailMovie: contentMap),

            ContentListView(
              contentId: widget.contentId,
              isTvMovie: widget.isTvMovie,
            ),

            // watch list like Rating etc Icons and management
            IconWork(
              movieId: widget.contentId,
              isTvMovie: widget.isTvMovie,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
              child: Column(
                children: [
                  CircularPercentIndicator(
                    radius: 60.0,
                    lineWidth: 15,
                    percent: doublepoint, // doublenum,
                    progressColor: const Color.fromARGB(255, 255, 141, 54),
                    backgroundColor: Color.fromARGB(255, 248, 220, 184),
                    circularStrokeCap: CircularStrokeCap.round,
                    center: new Text("${singlepoint}0%"),
                  ),
                  const Gap(20),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "User Score",
                    ),
                  )
                ],
              ),
            ),

            // here there budget revenue and popularity
            MoviInfo(detailMovie: contentMap),

            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      "TOP Billed Cast",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Gap(30),
                  Container(
                      width: screenSize.width,
                      height: 200,
                      child: PeopleCard(
                          movieData: contentCast, supporter: "cast")),
                  const Gap(30),
                ],
              ),
            ),

            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Other Crew",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Gap(30),
                  Container(
                      width: screenSize.width,
                      height: 200,
                      child: PeopleCard(
                          movieData: contentCast, supporter: "crew")),
                  const Gap(30),
                ],
              ),
            ),
            Gap(30),

            Container(
              margin: const EdgeInsets.only(
                  top: 70, left: 20, right: 50, bottom: 20),
              alignment: Alignment.centerLeft,
              child: Text(
                "Similar ${widget.isTvMovie ? "TvSerise" : "Movies"}",
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
            ),

            // the recommnedation of movies

            Container(
              width: screenSize.width,
              height: 400,
              child: Similar(
                movieId: contentMap["id"],
                ismovie: widget.isTvMovie,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  top: 70, left: 20, right: 50, bottom: 20),
              alignment: Alignment.centerLeft,
              child: Text(
                "Recommended ${widget.isTvMovie ? "TvSerise" : "Movies"}",
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
            ),

            Container(
              width: screenSize.width,
              height: 400,
              child: Recommended(
                movieId: contentMap["id"],
                ismovie: widget.isTvMovie,
              ),
            ),
            Gap(70),
            // here the rating work will be shown

            Container(
              child: RatingWork(
                movieId: contentMap["id"],
                isMovie: widget.isTvMovie,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
