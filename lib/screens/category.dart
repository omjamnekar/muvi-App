import 'dart:ui';

import 'package:cinema/provider/riv.dart';

import 'package:cinema/widget/datailScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryDiscover extends ConsumerStatefulWidget {
  CategoryDiscover({super.key, required this.content, required this.isbool});

  Map content;
  final bool isbool;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    // TODO: implement createState
    return _CategoryDiscoverState();
  }
}

double bottomPosition = 0;
bool isopen = false;

class _CategoryDiscoverState extends ConsumerState<CategoryDiscover> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(counterStatProvider);

    // print(widget.content);

    final Map moviePopular = state.when(
      data: (data) => data ?? {}, // If data is null, use an empty map
      loading: () => {}, // Handle loading state
      error: (error, stack) => {}, // Handle error state
    );
    var screenSize = MediaQuery.of(context).size;

    final pageController = PageController(initialPage: 5);
    // print(content);
    // print(content["results"].length);
    // int item = moviePopular["results"].length;
    if (state is AsyncLoading) {
      // If data is still loading, display circular indicator
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (moviePopular.isEmpty) {
      // If data is still loading, display circular indicator
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.horizontal,
        controller: pageController,
        itemCount: 20,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              Container(
                width: screenSize.width,
                height: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://image.tmdb.org/t/p/w500${widget.content["results"][index]["poster_path"]}",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    const Color.fromARGB(55, 255, 255, 255)
                        .withOpacity(0.1), // Adjust the opacity as needed
                    BlendMode.darken,
                  ),
                  child: Container(
                    color: Color.fromARGB(136, 49, 49,
                        49), // This color will be blended with the image
                  ),
                ),
              ),
              Column(
                // mainAxisAlignment: MainAxisAlignment.st,
                // crossAxisAlignment: c,
                children: [
                  // go to the back
                  const Gap(23),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: buildBlur(
                          child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          // margin: const EdgeInsets.all(10),
                          width: 65,
                          height: 65,

                          // padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: const Color.fromARGB(36, 250, 250, 250),
                          ),
                          child: Transform.translate(
                            offset: const Offset(6, 0),
                            child: const Icon(
                              Icons.arrow_back_ios,
                              size: 40,
                              color: Color.fromARGB(167, 255, 255, 255),
                            ),
                          ),
                        ),
                      )),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      margin: const EdgeInsets.only(left: 20),
                      width: 65,
                      height: 65,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        // border: Border.all(color: Colors.white, width: 1),
                        borderRadius: BorderRadius.circular(50),
                        color: Color.fromARGB(196, 255, 111, 0),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          margin: EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/image/heart-P.png"),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Gap(100),

                  Container(
                    // width: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            width: 250,
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              widget.content["results"][index]
                                          ["original_title"] !=
                                      null
                                  ? "${widget.content["results"][index]["original_title"]}"
                                  : "${widget.content["results"][index]["original_name"]}",
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 40,
                                  height: 0.9,
                                  fontWeight: FontWeight.w700),
                              maxLines: 5,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: buildBlur(
                                child: GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                // margin: const EdgeInsets.all(10),
                                width: 85,
                                height: 85,

                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color:
                                      const Color.fromARGB(36, 255, 255, 255),
                                ),
                                child: Container(
                                  width: 40,
                                  height: 60,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                        "assets/image/logo-white.png",
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Gap(20),
                ],
              ),
              Positioned(
                bottom: 150,
                child: Container(
                  // width: double.infinity,
                  // width: screenSize.width,
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      buildBlur(
                        child: Container(
                          width: 130,
                          height: 130,
                          color: const Color.fromARGB(36, 255, 255, 255),
                          child: Center(
                            child: Text(
                              "${widget.content["results"][index]["popularity"]} \n Popularity",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 20,
                                height: 1,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Gap(5),
                      buildBlur(
                        child: Container(
                          width: 120,
                          height: 120,
                          color: const Color.fromARGB(129, 255, 111, 0),
                          child: const Icon(
                            Icons.play_arrow_rounded,
                            size: 100,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const Gap(5),
                      buildBlur(
                        child: Container(
                          width: 130,
                          height: 130,
                          color: const Color.fromARGB(36, 255, 255, 255),
                          child: Center(
                            child: Text(
                              "${widget.content["results"][index]["vote_average"]} \n Rating",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 20,
                                height: 1,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Gap(20),

              DraggableScrollableSheet(
                  initialChildSize: isopen == true
                      ? 0.06
                      : 0.06, // Adjust the initial size as needed
                  minChildSize: isopen == true ? 0.06 : 0.06,
                  // Adjust the minimum size as needed
                  maxChildSize: 1, // Adjust the maximum size as needed
                  builder: (context, scrollController) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 255, 245, 237),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: DetailScreen(
                          contentID: widget.content["results"][index]["id"],
                          isTvMovie: widget.isbool,
                        ),
                      ),
                    );
                  }),
            ],
          );
        },
      ),
    );
  }

  Widget buildBlur({
    required Widget child,
    double sigmX = 10,
    double sigmY = 10,
  }) =>
      ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: sigmX, sigmaY: sigmY),
          child: child,
        ),
      );
}
