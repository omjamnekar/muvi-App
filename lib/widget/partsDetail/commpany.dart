import 'package:cinema/widget/custom/customD2.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class Commpany extends StatelessWidget {
  const Commpany({
    super.key,
    required this.detailMovie,
  });

  final Map detailMovie;

  @override
  Widget build(BuildContext context) {
    ImageProvider<Object> logoImage;

    if (detailMovie["production_companies"] != null &&
        detailMovie["production_companies"].isNotEmpty &&
        detailMovie["production_companies"][0]["logo_path"] != null) {
      logoImage = NetworkImage(
        "https://image.tmdb.org/t/p/w500${detailMovie["production_companies"][0]["logo_path"]}",
      );
    } else if (detailMovie["networks"] != null &&
        detailMovie["networks"].isNotEmpty &&
        detailMovie["networks"][0]["logo_path"] != null) {
      logoImage = NetworkImage(
        "https://image.tmdb.org/t/p/w500${detailMovie["networks"][0]["logo_path"]}",
      );
    } else {
      logoImage = AssetImage("assets/image/logo-null.jpg");
    }

    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomDialogBox2(
              key: Key(AutofillHints.birthday),
              title: detailMovie["production_companies"][0]["name"] != null
                  ? "${detailMovie["production_companies"][0]["name"]}"
                  : "loading",
              descriptions:
                  "you can see movies, shows ,Top rated content ,Popular content and much more",
              text: 'More',
              comimage:
                  detailMovie["production_companies"][0]["logo_path"] != null
                      ? "${detailMovie["production_companies"][0]["logo_path"]}"
                      : "/tQZIt59BLw3b0b6rHJRqv4Dvrpd.png",
              img: "assets/image/we.png",
              change: () => Navigator.pop(context),
            );
          },
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // here the logo of comany that made the movie

            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(30)),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: logoImage,
                ),
              ),
            ),
            const Gap(20),
            SizedBox(
              // height: 60,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 200,
                    // height: 25,
                    decoration: const BoxDecoration(
                        // borderRadius: BorderRadius.all(Radius.circular(30)),

                        ),
                    child: Text(
                      (detailMovie["production_companies"]?.isNotEmpty ??
                                  false) &&
                              (detailMovie["production_companies"][0]["name"] !=
                                  null)
                          ? "${detailMovie["production_companies"][0]["name"]}"
                          : (detailMovie["networks"]?.isNotEmpty ?? false) &&
                                  (detailMovie["networks"][0]["name"] != null)
                              ? "${detailMovie["networks"][0]["name"]}"
                              : "Loading",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        height: 1,
                        letterSpacing: 0.7,
                      ),
                    ),
                  ),
                  const Gap(6),

                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.amber[900],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          (() {
                            if (detailMovie != null) {
                              if (detailMovie["production_companies"] != null &&
                                  detailMovie["production_companies"]
                                      .isNotEmpty &&
                                  detailMovie["production_companies"][0]
                                          ["origin_country"] !=
                                      null) {
                                return "${detailMovie["production_companies"][0]["origin_country"]}";
                              } else if (detailMovie["networks"] != null &&
                                  detailMovie["networks"].isNotEmpty &&
                                  detailMovie["networks"][0]
                                          ["origin_country"] !=
                                      null) {
                                return "${detailMovie["networks"][0]["origin_country"]}";
                              } else {
                                return "Loading";
                              }
                            } else {
                              return "Loading";
                            }
                          })(),
                          style: GoogleFonts.poppins(color: Colors.white),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          // color: Color.fromARGB(255, 10, 190, 40),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          (() {
                            if (detailMovie != null &&
                                detailMovie["production_countries"] != null &&
                                detailMovie["production_countries"]
                                    .isNotEmpty) {
                              return "${detailMovie["production_countries"][0]["name"]}";
                            } else {
                              return "Loading";
                            }
                          })(),
                          style: GoogleFonts.poppins(
                            color: const Color.fromARGB(255, 85, 85, 85),
                          ),
                        ),
                      ),
                    ],
                  )
                  //  Spacer(),
                ],
              ),
            ),

            const Spacer(),
            const Icon(
              Icons.amp_stories_sharp,
              size: 30,
              color: Color.fromARGB(221, 58, 58, 58),
            )
          ],
        ),
      ),
    );
  }
}
