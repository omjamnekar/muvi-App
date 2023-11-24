import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PeopleCard extends StatelessWidget {
  PeopleCard({super.key, required this.movieData, required this.supporter});

  final Map movieData;
  final String supporter;

  Widget build(BuildContext context) {
    // print(movieData);

    if (movieData.isEmpty) {
      return Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      itemCount: movieData[supporter].length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        Map<String, dynamic> castMember = movieData[supporter][index];

        if (castMember.isEmpty) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return GestureDetector(
          onTap: () {},
          child: Container(
              width: 120,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 244, 231, 215),
                  borderRadius: BorderRadius.circular(10)),
              height: 250,
              child: Column(
                children: [
                  Container(
                    width: 120,
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(castMember["profile_path"] !=
                                    null
                                ? "https://image.tmdb.org/t/p/w500${castMember["profile_path"]}"
                                : "https://static.vecteezy.com/system/resources/previews/008/442/086/non_2x/illustration-of-human-icon-user-symbol-icon-modern-design-on-blank-background-free-vector.jpg"))),
                  ),
                  Container(
                    // height: 20,
                    alignment: Alignment.topLeft,
                    margin: const EdgeInsets.only(left: 10, top: 10),
                    child: SingleChildScrollView(
                      child: Text(
                        castMember["character"] != null
                            ? "${castMember["character"]}"
                            : "",
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700, height: 0.9),
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
                        "${castMember["original_name"]}",
                        maxLines: 2,
                        style: GoogleFonts.poppins(height: 1),
                      ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    alignment: Alignment.topLeft,
                    margin:
                        const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                    child: Text(
                      "${castMember["known_for_department"]}",
                      style: GoogleFonts.poppins(
                          height: 1, color: Colors.amber[900]),
                    ),
                  )
                ],
              )),
        );
      },
    );
  }
}
