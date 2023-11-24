import 'package:cinema/screens/category.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class CardHome extends StatefulWidget {
  CardHome({
    super.key,
    required this.movie,
    required this.heading,
    required this.content,
    required this.index,
    required this.size,
    required this.isbool,
  });
  Map movie;
  String heading;
  int index;
  double size;
  String content;
  bool isbool;

  @override
  State<CardHome> createState() => _CardHomeState();
}

class _CardHomeState extends State<CardHome> {
//   @override
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
  Widget build(BuildContext context) {
    // final s = ref.watch(counterStatProvider);
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (isSelected[widget.index] == true) {
              isSelected[widget.index] = false;
            } else {
              isSelected[widget.index] = true;
            }
          });
        },
        onDoubleTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CategoryDiscover(
                  content: widget.movie,
                  isbool: widget.isbool,
                ),
              ));
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(60),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: isSelected[widget.index] == true ? 650 : 360,

            decoration: BoxDecoration(
              image: DecorationImage(
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(
                      0.6), // You can adjust the color and opacity here
                  BlendMode.darken, // You can change the blend mode if needed
                ),
                image: NetworkImage(
                    "https://image.tmdb.org/t/p/w500${widget.movie["results"][1]["backdrop_path"]}"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //Details of poster movie
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "${widget.movie["results"][1]["vote_average"]} ETH",
                              maxLines: 4,
                              style: GoogleFonts.poppins(
                                fontSize: 43, color: Colors.white,
                                // fontWeight: FontWeight.w800
                              ),
                            ),
                            // vote_average
                            Container(
                              width: 200,
                              child: Text(
                                  widget.movie["results"][1][widget.content],
                                  maxLines: 4,
                                  style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    color: Colors.white,
                                    height: 1,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        margin: const EdgeInsets.all(20),
                        width: 80,
                        height: 80,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: const Color.fromARGB(75, 255, 255, 255),
                          // backgroundBlendMode: BlendMode.clear,
                        ),
                        child: Image.asset(
                          "assets/image/logo-white.png",
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),

                    // Popular movie
                  ],
                ),
                isSelected[widget.index] == true
                    ? SingleChildScrollView(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            widget.movie["results"][1]["overview"],
                            style: GoogleFonts.poppins(color: Colors.white),
                          ),
                        ),
                      )
                    : Container(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // logo
                    Container(
                      // width: 80,
                      // width: double.maxFinite,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                widget.heading,
                                style: GoogleFonts.poppins(
                                  fontSize: widget.size,
                                  height: 1,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.only(right: 20),
                      child: ElevatedButton(
                        child: Text(
                          "DISCCOVER ",
                          style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: const Color.fromARGB(207, 0, 0, 0)),
                        ),
                        style: ButtonStyle(
                            padding: MaterialStatePropertyAll(
                                const EdgeInsets.all(20)),
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.white)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CategoryDiscover(
                                content: widget.movie,
                                isbool: widget.isbool,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
            // color: Colors.deepPurple,
          ),
        ),
      ),
    );
  }
}
