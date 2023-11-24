import 'dart:async';
import 'dart:async';
import 'dart:ui';
import 'package:cinema/widget/verify/checkLogin.dart';
import 'package:cinema/widget/verify/creatAccount.dart';
import 'package:cinema/widget/verify/loginPage.dart';
import 'package:cinema/widget/slider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tmdb_api/tmdb_api.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  late Timer _timer;
  int _currentIndex = 0;
  Map<dynamic, dynamic> image = {};
  Map<dynamic, dynamic> popular = {};
  final String _apiKey = "cf3e00ea296dc09f246e77b036845049";
  final _readaccesstoken =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjZjNlMDBlYTI5NmRjMDlmMjQ2ZTc3YjAzNjg0NTA0OSIsInN1YiI6IjY1NGU1N2E1ZDQ2NTM3MDBhYjk1MWU4NyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.qPLTdMHqloyXvRf9QWKmH__NrlHNZmJZUziWkXJKo00";

  bool selected = false;

  bool loginSection = false;
  final ScrollController _scrollController = ScrollController();
  bool _reverse = false;
  bool _creatAcc = false;
  bool _login = false;

  @override
  void initState() {
    super.initState();
    _loadMovie();
    startTimer();
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        selected = !selected;
      });
    });
    startAutoScroll();
  }

  void _loadMovie() async {
    final tmdb = TMDB(
      ApiKeys(_apiKey, _readaccesstoken),
      logConfig: const ConfigLogger(
        showLogs: true,
        showErrorLogs: true,
      ),
    );
    final topMovies = await tmdb.v3.movies.getNowPlaying();
    final popularTv = await tmdb.v3.tv.getPopular();

    setState(() {
      image = topMovies;
      popular = popularTv;
      // print(popular);
    });
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (image['results'] != null) {
        setState(() {
          _currentIndex =
              (_currentIndex + 1) % (image['results']!.length) as int;
        });
      }
    });
  }

  void startAutoScroll() {
    Future.delayed(Duration(seconds: 2), () {
      if (_scrollController.hasClients) {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          setState(() {
            _reverse = !_reverse;
          });
        } else if (_scrollController.position.pixels ==
            _scrollController.position.minScrollExtent) {
          setState(() {
            _reverse = !_reverse;
          });
        }

        _scrollController.animateTo(
          _reverse
              ? _scrollController.position.minScrollExtent
              : _scrollController.position.maxScrollExtent,
          duration: Duration(seconds: 5),
          curve: Curves.linear,
        );
        startAutoScroll();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 60, 60, 60),
      body: SafeArea(
        child: Center(
          child: image['results'] != null
              ? Stack(
                  children: [
                    for (var i = 0; i < image['results']!.length; i++)
                      AnimatedOpacity(
                        duration: const Duration(seconds: 3),
                        opacity: i == _currentIndex ? 1.0 : 0.0,
                        child: ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(
                                0.8), // Adjust opacity level for darkness
                            BlendMode.srcATop,
                          ),
                          child: Container(
                            width: double.infinity,
                            height: double.infinity,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  "https://image.tmdb.org/t/p/w500" +
                                      (image['results']![i]['poster_path'] ??
                                          ''),
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),

                    AnimatedPositioned(
                      bottom: selected ? 1 : -544,
                      // right: selected ? 0 : -29,
                      duration: Duration(seconds: 2),
                      curve: Curves.fastOutSlowIn,
                      child: Transform.rotate(
                        angle: -0.6,
                        child: Container(
                          height: 400,
                          width: 700,
                          color: Color.fromARGB(106, 67, 67, 67),
                          // child: SliderMethod(imageList: popular),
                        ),
                      ),
                    ),

                    //main slider
                    AnimatedPositioned(
                      bottom: selected ? -15 : -600,
                      // right: selected ? -30 : -29,
                      duration: Duration(seconds: 2),
                      curve: Curves.fastOutSlowIn,
                      child: Transform.rotate(
                        angle: -0.6,
                        child: Container(
                          height: 400,
                          width: 800,
                          color: Color.fromARGB(53, 255, 186, 134),
                          child: SliderMethod(imageList: popular),
                        ),
                      ),
                    ),

                    AnimatedPositioned(
                      top: selected ? 23 : -600,
                      duration: Duration(seconds: 3),
                      curve: Curves.linearToEaseOut,
                      child: Container(
                        // height: 400,
                        width: 500,
                        margin: const EdgeInsets.only(left: 10),
                        // color: Color.fromARGB(255, 243, 170, 33),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 70,
                              height: 70,
                              margin: const EdgeInsets.only(top: 40),
                              // height: 4,

                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                // colorFilter:
                                // ColorFilter.mode(Color(0xFFff9505), BlendMode.dst),
                                image: AssetImage(
                                  "assets/image/we.png",
                                ),
                              )),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text("Welcome to\n Muvi app",
                                style: GoogleFonts.poppins(
                                  fontSize: 40,
                                  height: 1.1,
                                  fontWeight: FontWeight.w800,
                                  color: Color.fromARGB(255, 255, 130, 41),
                                )),
                            const SizedBox(
                              height: 30,
                            ),
                            Text(
                                "Discover the Latest Movies,Explore\nTrailers, Reviews,\n and More!",
                                style: GoogleFonts.poppins(
                                  fontSize: 30,
                                  height: 1.2,
                                  fontWeight: FontWeight.w800,
                                  color: Color.fromARGB(255, 172, 172, 172),
                                ))
                          ],
                        ),
                      ),
                    ),

                    //Button

                    AnimatedPositioned(
                      right: selected ? 10 : -280,
                      curve: Curves.easeInOutCubic,
                      top: 20,
                      height: 70,
                      width: 180,
                      duration: Duration(seconds: 1),
                      child: TextButton.icon(
                        onPressed: () {
                          setState(() {
                            selected = false;
                            loginSection = true;
                          });
                        },
                        style: const ButtonStyle(
                          padding: MaterialStatePropertyAll(EdgeInsets.only(
                              left: 5, top: 5, right: 5, bottom: 5)),
                          animationDuration: Duration(seconds: 2),
                          iconColor: MaterialStatePropertyAll(
                              Color.fromARGB(255, 242, 242, 242)),
                          backgroundColor: MaterialStatePropertyAll(
                              Color.fromARGB(255, 255, 130, 41)),
                        ),
                        label: const Text(
                          "Start",
                          style: TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        icon: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.fast_forward,
                              size: 40,
                            ),
                            // Icon(Icons.fast_forward)
                          ],
                        ),
                      ),
                    ),

                    _creatAcc == true
                        ? SingleChildScrollView(
                            child: Expanded(
                              child: Center(
                                child: AnimatedPositioned(
                                  top: loginSection
                                      ? MediaQuery.of(context).size.height / 2 -
                                          900
                                      : -1900,
                                  duration: Duration(seconds: 6),
                                  curve: Curves.easeInOut,
                                  child: CreatAccount(
                                    send: (value, ctc, create) {
                                      setState(() {
                                        selected = value;
                                        loginSection = ctc;
                                        _creatAcc = create;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(),

                    loginSection == true
                        ? SingleChildScrollView(
                            child: Expanded(
                              child: Center(
                                child: AnimatedPositioned(
                                  top: loginSection
                                      ? MediaQuery.of(context).size.height / 2 -
                                          900
                                      : -1900,
                                  duration: Duration(seconds: 6),
                                  curve: Curves.easeInOut,
                                  child: CheckLogin(
                                    loginSection: loginSection,
                                    selected: (value, ctc, create, login) {
                                      setState(() {
                                        selected = value;
                                        loginSection = ctc;
                                        _creatAcc = create;
                                        _login = login;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(),

                    _login == true
                        ? SingleChildScrollView(
                            child: Expanded(
                              child: Center(
                                child: AnimatedPositioned(
                                  top: loginSection
                                      ? MediaQuery.of(context).size.height / 2 -
                                          900
                                      : -1900,
                                  duration: Duration(seconds: 6),
                                  curve: Curves.easeInOut,
                                  child: LoginPage(
                                    send: (value, ctc, create) {
                                      setState(() {
                                        selected = value;
                                        loginSection = ctc;
                                        _login = create;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                )
              : const CircularProgressIndicator(),
        ),
      ),
    );
  }
}

// #ffc971 to RGBA: rgba(255, 201, 113, 1.0)
// #ffb627 to RGBA: rgba(255, 182, 39, 1.0)
// #ff9505 to RGBA: rgba(255, 149, 5, 1.0)
// #e2711d to RGBA: rgba(226, 113, 29, 1.0)
// #cc5803 to RGBA: rgba(204, 88, 3, 1.0)
//
Color color1 = const Color(0xFFffc971); // #ffc971
Color color2 = const Color(0xFFffb627); // #ffb627
Color color3 = const Color(0xFFff9505); // #ff9505
Color color4 = const Color(0xFFe2711d); // #e2711d
Color color5 = const Color(0xFFcc5803); // #cc5803
