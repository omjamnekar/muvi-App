import 'dart:ui';

import 'package:cinema/class/session_info.dart';
import 'package:cinema/provider/get.dart';
import 'package:cinema/provider/riv.dart';

import 'package:cinema/widget/partsDetail/commpany.dart';
import 'package:cinema/widget/partsDetail/heading.dart';
import 'package:cinema/widget/partsDetail/icon_Work.dart';
import 'package:cinema/widget/partsDetail/movi_Content.dart';
import 'package:cinema/widget/partsDetail/movie_Info.dart';
import 'package:cinema/widget/partsDetail/people_Card.dart';
import 'package:cinema/widget/partsDetail/rating_work.dart';
import 'package:cinema/widget/partsDetail/recommend.dart';
import 'package:cinema/widget/partsDetail/similar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:percent_indicator/percent_indicator.dart';

class DetailScreen extends ConsumerStatefulWidget {
  const DetailScreen({
    required this.contentID,
    required this.isTvMovie,
  });

  final int contentID;
  final bool isTvMovie;

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends ConsumerState<DetailScreen> {
  List<Widget> genreTextSpans = [];
  bool add = false;

  _addComment() {
    setState(() {
      add = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    // movie
    // ////////////////////////////////////////////////////////////////////////////
    final int id = widget.contentID;

// print("Simplified Map: $simplifiedMap");

    // print(id);

    final state = ref.watch(movieDetailSp(id));

    final castMovie = ref.watch(movieCast(id));

//  final instance = ref.watch(personDetailProvider);
    // tv
    // /////////////////////////////////////////////////////////////////////////////

    final tvD = ref.watch(tvDetailSp(id));
    final tvCaste = ref.watch(tvCast(id));
    String ismoive = "";
    //  complex ///////////////////////////////////////////////////////////////////
    // final genre = ref.watch(genere);

    // comparing if the data is of movie or tv
    final Map detailMovie;
    final Map detailCast;
    if (widget.isTvMovie == true) {
      detailMovie = tvD.when(
        data: (data) => data ?? {},
        loading: () => {},
        error: (error, stack) => {},
      );

      ismoive = "Series";
      detailCast = tvCaste.when(
        /// the cast of movie is remaining
        data: (data) => data ?? {},
        loading: () => {},
        error: (error, stack) => {},
      );
    } else {
      detailMovie = state.when(
        data: (data) => data ?? {},
        loading: () => {},
        error: (error, stack) => {},
      );
      ismoive = "Movies";
      detailCast = castMovie.when(
        /// the cast of movie is remaining
        data: (data) => data ?? {},
        loading: () => {},
        error: (error, stack) => {},
      );
    }

    // print("daarrr //////////////////////////////////////////////////////");
    // print(widget.isTvMovie);
    // print("detail movie");
    // print(detailMovie);
    // print("detail show");
    // print(detailCast);

    // print(detailMovie);

    double doublenum = (detailMovie["vote_average"] != null
            ? detailMovie["vote_average"]
            : 2) /
        10;
    // 0.2
    double singleDig = doublenum * 10;

    int singlepoint = singleDig.toInt();
    double doublepoint = singleDig / 10;

// // checking if the data id not loaded yet
    var screenSize = MediaQuery.of(context).size;

    if (state is AsyncLoading) {
      // If data is still loading, display circular indicator
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (detailMovie.isEmpty) {
      // If data is still loading, display circular indicator
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          //indicator of the detail screen
          const SizedBox(
            height: 13,
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
              height: 4,
              width: 30,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(221, 72, 72, 72),
                  borderRadius: BorderRadius.circular(10)),
            ),
          ),
          const Gap(10),

          //heading of the detail
          HeadingDetail(detailMovie: detailMovie),
          const Gap(10),
          // main section of photo

          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  // Return the Dialog widget
                  return AlertDialog(
                    content: Container(
                      width: 600,
                      margin: const EdgeInsets.only(top: 10),
                      height: 800,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(detailMovie["poster_path"] != null
                              ? "https://image.tmdb.org/t/p/w500${detailMovie["poster_path"]}"
                              : "https://t3.ftcdn.net/jpg/00/86/56/12/360_F_86561234_8HJdzg2iBlPap18K38mbyetKfdw1oNrm.jpg"),
                        ),
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          // Close the dialog
                          Navigator.of(context).pop();
                        },
                        child: Text('Close'),
                      ),
                    ],
                  );
                },
              );
            },
            child: Container(
              width: 370,
              height: 400,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(30),
                ),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(detailMovie["poster_path"] != null
                      ? "https://image.tmdb.org/t/p/w500${detailMovie["poster_path"]}"
                      : "https://t3.ftcdn.net/jpg/00/86/56/12/360_F_86561234_8HJdzg2iBlPap18K38mbyetKfdw1oNrm.jpg"),
                ),
              ),
            ),
          ),
          const Gap(30),

          // company content
          Commpany(detailMovie: detailMovie),
          const Gap(0),

          MovieContent(detailMovie: detailMovie),

          // watch list like Rating etc Icons and management
          IconWork(
            movieId: widget.contentID,
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
          MoviInfo(detailMovie: detailMovie),

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
                    child:
                        PeopleCard(movieData: detailCast, supporter: "cast")),
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
                    child:
                        PeopleCard(movieData: detailCast, supporter: "crew")),
                const Gap(30),
              ],
            ),
          ),
          Gap(30),

          Container(
            margin:
                const EdgeInsets.only(top: 70, left: 20, right: 50, bottom: 20),
            alignment: Alignment.centerLeft,
            child: Text(
              "Similar ${ismoive}",
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
              movieId: detailMovie["id"],
              ismovie: widget.isTvMovie,
            ),
          ),
          Container(
            margin:
                const EdgeInsets.only(top: 70, left: 20, right: 50, bottom: 20),
            alignment: Alignment.centerLeft,
            child: Text(
              "Recommended ${ismoive}",
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
              movieId: detailMovie["id"],
              ismovie: widget.isTvMovie,
            ),
          ),
          Gap(70),
          // here the rating work will be shown

          Container(
            child: RatingWork(
              movieId: detailMovie["id"],
              isMovie: widget.isTvMovie,
            ),
          ), // movie content
        ],
      ),
    );
  }

  Widget buildBlur(
          {required Widget child, double sigmX = 10, double sigmY = 10}) =>
      ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: sigmX, sigmaY: sigmY),
          child: child,
        ),
      );
}
