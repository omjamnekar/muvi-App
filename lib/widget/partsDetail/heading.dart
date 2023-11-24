import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeadingDetail extends StatelessWidget {
  const HeadingDetail({
    super.key,
    required this.detailMovie,
  });

  final Map detailMovie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.all(20),
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30), //border corner radius
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1), //color of shadow
                  spreadRadius: 5, //spread radius
                  blurRadius: 7, // blur radius
                  offset: const Offset(0, 2), // changes position of shadow
                  //first paramerter of offset is left-right
                  //second parameter is top to down
                ),
                //you can set more BoxShadow() here
              ],
            ),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.amber[900],
            ),
          ),
          Container(
            width: 150,
            child: Text(
              (() {
                if (detailMovie["original_title"] != null) {
                  return "${detailMovie["original_title"]}";
                } else if (detailMovie["original_name"] != null) {
                  return "${detailMovie["original_name"]}";
                } else {
                  return "Loading";
                }
              })(),
              maxLines: 5,
              style: GoogleFonts.poppins(
                fontSize: 25,
                color: Colors.black87,
                height: 1,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 10, top: 10),
            width: 60,
            height: 60,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              // border: Border.all(color: Colors.white, width: 1),
              borderRadius: BorderRadius.circular(50),
              color: const Color.fromARGB(196, 255, 111, 0),
            ),
            child: Align(
              alignment: Alignment.center,
              child: Container(
                margin: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/image/heart-P.png"),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
