import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class MoviInfo extends StatelessWidget {
  const MoviInfo({
    super.key,
    required this.detailMovie,
  });

  final Map detailMovie;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      detailMovie["budget"] != null
                          ? "${detailMovie["budget"].toString()}"
                          : " --",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Colors.amber[900],
                      ),
                    ),
                    Text(
                      "Budget",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: const Color.fromARGB(255, 18, 18, 18),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              // revenue of the movie
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      detailMovie["revenue"] != null
                          ? "${detailMovie["revenue"].toString()}"
                          : " --",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Colors.amber[900],
                      ),
                    ),
                    Text(
                      "Revenue",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: const Color.fromARGB(255, 18, 18, 18),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Gap(20),
          Row(
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      detailMovie["vote_average"] != null
                          ? "${detailMovie["vote_average"].toString()}"
                          : " --",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Colors.amber[900],
                      ),
                    ),
                    Text(
                      "Vote Average",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: const Color.fromARGB(255, 18, 18, 18),
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              // revenue of the movie
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      detailMovie["popularity"] != null
                          ? "${detailMovie["popularity"].toString()}"
                          : " --",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: Colors.amber[900],
                      ),
                    ),
                    Text(
                      "Popularity",
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        color: const Color.fromARGB(255, 18, 18, 18),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
