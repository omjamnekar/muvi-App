import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  // controller is to keep the track of page

  PageController _controller = PageController();

  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            children: [],
          ),

          //page indicator

          Container(
            alignment: Alignment(0, 0.5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    _controller.jumpToPage(2);
                  },
                  child: Text(
                    "Skip",
                    style:
                        GoogleFonts.poppins(fontSize: 20, color: Colors.white),
                  ),
                ),
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                ),

                //next page
                onLastPage
                    ? GestureDetector(
                        onTap: () {
                          _controller.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(108, 255, 248, 224)),
                          child: Text(
                            "Done",
                            style: GoogleFonts.poppins(
                                fontSize: 20, color: Colors.white),
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          _controller.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                        child: Text(
                          "Next",
                          style: GoogleFonts.poppins(
                              fontSize: 20, color: Colors.white),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
