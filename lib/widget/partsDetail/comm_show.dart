import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class CommShow extends ConsumerStatefulWidget {
  CommShow(
      {super.key,
      required this.comment,
      required this.indexw,
      required this.format});

  Map comment;
  int indexw;
  String format;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CommShowState();
}

class _CommShowState extends ConsumerState<CommShow> {
  @override
  Widget build(BuildContext context) {
    Map review = widget.comment;

    int index = widget.indexw;
    return Scaffold(
      appBar: AppBar(
        actions: [
          // Container(
          //   margin: const EdgeInsets.all(20),
          //   height: 60,
          //   width: 60,
          //   decoration: BoxDecoration(
          //     color: Colors.white,
          //     borderRadius: BorderRadius.circular(30), //border corner radius
          //     boxShadow: [
          //       BoxShadow(
          //         color: Colors.grey.withOpacity(0.1), //color of shadow
          //         spreadRadius: 5, //spread radius
          //         blurRadius: 7, // blur radius
          //         offset: const Offset(0, 2), // changes position of shadow
          //         //first paramerter of offset is left-right
          //         //second parameter is top to down
          //       ),
          //       //you can set more BoxShadow() here
          //     ],
          //   ),
          //   child: Icon(
          //     Icons.arrow_back_ios_new_rounded,
          //     color: Colors.amber[900],
          //   ),
          // ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(30),
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    margin: const EdgeInsets.only(
                      bottom: 10,
                    ),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        color: Color.fromARGB(208, 241, 172, 98),
                        width: 3,
                      ),
                      image: DecorationImage(
                        image: NetworkImage(
                          review["results"][index]["author_details"]
                                      ["avatar_path"] !=
                                  null
                              ? "https://image.tmdb.org/t/p/w500${review["results"][index]["author_details"]["avatar_path"]}"
                              : "https://static.vecteezy.com/system/resources/previews/008/442/086/non_2x/illustration-of-human-icon-user-symbol-icon-modern-design-on-blank-background-free-vector.jpg",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Gap(10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        review["results"][index]["author_details"]["username"],
                        style: GoogleFonts.poppins(
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Container(
                        width: 170,
                        child: Text(
                          review["results"][index]["author_details"]["name"],
                          style: GoogleFonts.poppins(),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      // Star(),
                    ],
                  ),
                  Spacer(),
                  Text(widget.format),
                ],
              ),
              Container(
                width: 400,
                child: Text(
                  review["results"][index]["content"],
                  // maxLines: 13,
                  // overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    height: 1.2,
                  ),
                ),
              ),
              Gap(20),
            ],
          ),
        ),
      ),
    );
  }
}
