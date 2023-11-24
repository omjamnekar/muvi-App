import 'package:cinema/Service/content_Display.dart';
import 'package:cinema/provider/riv.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class Recommended extends ConsumerStatefulWidget {
  Recommended({super.key, required this.movieId, required this.ismovie});

  int movieId;
  bool ismovie;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RecommendedState();
}

class _RecommendedState extends ConsumerState<Recommended> {
  @override
  Widget build(BuildContext context) {
    // print(widget.movieId);

    Map recommended;

    if (widget.ismovie == true) {
      final recommendTv = ref.watch(recommendtv(widget.movieId));
      recommended = recommendTv.when(
        data: (data) => data ?? {},
        loading: () => {},
        error: (error, stack) => {},
      );
    } else {
      final recommendedState = ref.watch(recommend(widget.movieId));
      recommended = recommendedState.when(
        data: (data) => data ?? {},
        loading: () => {},
        error: (error, stack) => {},
      );
    }
    // print(recommended);

    if (recommended.isEmpty) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return ListView.builder(
        itemCount: recommended["results"].length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          if (recommended.isEmpty) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ContentDisplay(
                            contentId: recommended["results"][index]["id"],
                            isTvMovie: widget.ismovie,
                          )));
            },
            child: Container(
                width: 200,
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 244, 231, 215),
                    borderRadius: BorderRadius.circular(10)),
                height: double.maxFinite,
                child: Column(
                  children: [
                    Container(
                      width: 200,
                      height: 400,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(recommended["results"][index]
                                          ["poster_path"] !=
                                      null
                                  ? "https://image.tmdb.org/t/p/w500${recommended["results"][index]["poster_path"]}"
                                  : "https://static.vecteezy.com/system/resources/previews/008/442/086/non_2x/illustration-of-human-icon-user-symbol-icon-modern-design-on-blank-background-free-vector.jpg"))),
                      child: Column(
                        children: [
                          Container(
                            // height: 20,
                            alignment: Alignment.topLeft,
                            margin: const EdgeInsets.only(left: 10, top: 10),
                            child: SingleChildScrollView(
                              child: Text(
                                recommended["results"][index]["title"] != null
                                    ? "${recommended["results"][index]["title"]}"
                                    : "${recommended["results"][index]["name"]}",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700,
                                  height: 0.9,
                                  color: Colors.white,
                                ),
                                maxLines: 2,
                              ),
                            ),
                          ),
                          Container(
                            height: 26,
                            alignment: Alignment.topLeft,
                            margin: const EdgeInsets.only(left: 10, top: 2),
                            child: SingleChildScrollView(
                              child: Text(
                                "${recommended["results"][index]["media_type"]}",
                                maxLines: 2,
                                style: GoogleFonts.poppins(
                                    height: 1, color: Colors.amber[900]),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    //TEXT WORK IS IN THE work
                  ],
                )),
          );
        });
  }
}
