import 'package:cinema/provider/get.dart';
import 'package:cinema/provider/riv.dart';
import 'package:cinema/widget/custom/customD3.dart';
import 'package:cinema/widget/partsDetail/comm_show.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl.dart';

class RatingWork extends ConsumerStatefulWidget {
  RatingWork({
    super.key,
    required this.movieId,
    required this.isMovie,
  });

  int movieId;
  bool isMovie;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RatingWorkState();
}

class _RatingWorkState extends ConsumerState<RatingWork> {
  double rating = 0.0;
  // MyClass myObject = MyClass();
  //  myObject.printFormattedDate();
  String formatDate(DateTime dateTime) {
    // Format the DateTime using the desired pattern
    final formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(dateTime);
  }

  TextEditingController comment = TextEditingController();

  bool add = false;
  bool isdone = false;

  @override
  Widget build(BuildContext context) {
    void addReview(int moviId, double rating) async {
      try {
        await ref.watch(revieWM([moviId, rating]));

        showDialog(
            context: context,
            builder: (BuildContext contexr) {
              return AlertDialog(
                actions: [
                  Container(
                    width: double.maxFinite,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 250,
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Comment has sended Successfully!",
                            style: GoogleFonts.poppins(fontSize: 30),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 20, left: 5),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.cancel,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text("your comment will be updated in 24hr"))
                ],
              );
            });
      } catch (e) {
        print("here is the error :$e");
      }
    }

    final now = DateTime.now();
    String currentTime = DateFormat('MM/dd/yyyy').format(now);
    Map review;

    if (widget.isMovie == true) {
      final reviewbeta = ref.watch(reviewTv(widget.movieId));
      review = reviewbeta.when(
        data: (data) => data ?? {},
        loading: () => {},
        error: (error, stack) => {},
      );
    } else {
      final reviewbeta = ref.watch(reviewMovie(widget.movieId));

      review = reviewbeta.when(
        data: (data) => data ?? {},
        loading: () => {},
        error: (error, stack) => {},
      );
    }
    // print(recommended);

    if (review.isEmpty) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if (review["results"].length == 0) {
      return Container(
          width: 300,
          height: 300,
          // color: Colors.amberAccent,
          child: Center(child: Text("No comments yet")));
    }
    // print(formattedDate);

    // print(review);

    // return Column(
    //   children: [
    //     TextField(),
    //   ],
    // );

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Reviews",
                style: GoogleFonts.poppins(
                    fontSize: 30,
                    color: Colors.amber[900],
                    fontWeight: FontWeight.bold),
              ),
              Material(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(255, 242, 236, 253),
                surfaceTintColor: const Color.fromARGB(255, 233, 220, 255),
                child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        print("true");
                        if (add) {
                          add = false;
                        } else {
                          add = true;
                        }
                      });
                    },
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Color.fromARGB(255, 242, 236, 253))),
                    label: Text(
                      "Write Review",
                      style: GoogleFonts.poppins(color: Colors.black),
                    ),
                    icon: const Icon(Icons.border_color_outlined)),
              )
            ],
          ),
        ),
        add == true
            ? Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                width: double.maxFinite,
                height: 300,
                child: Center(
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                add = false;
                              });
                            },
                            child: Icon(Icons.cancel,
                                color: Color.fromARGB(255, 254, 176, 176)),
                          )),
                      const Gap(30),
                      TextField(
                        maxLength: 500,
                        controller: comment,
                        decoration: InputDecoration(
                            hintText: "Comment",
                            hintStyle: TextStyle(
                                color:
                                    const Color.fromARGB(255, 187, 187, 187))),
                      ),
                      const Gap(20),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return CustomDialogBox3(
                                  key: UniqueKey(),
                                  update: (value) {
                                    setState(() {
                                      rating = value;
                                      isdone = true;
                                    });
                                  },
                                );
                              });
                        },
                        child: Row(
                          children: [
                            Text("Rate ${rating}/5"),
                            Icon(
                              Icons.star,
                              color: isdone
                                  ? Color.fromARGB(255, 243, 229, 35)
                                  : Colors.blueGrey[300],
                            ),
                          ],
                        ),
                      ),
                      const Gap(40),
                      ElevatedButton(
                        style: ButtonStyle(
                            padding: const MaterialStatePropertyAll(
                                EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 10)),
                            foregroundColor: MaterialStatePropertyAll(
                                Colors.deepPurpleAccent[300]),
                            backgroundColor: MaterialStatePropertyAll(
                                Colors.deepPurpleAccent[300])),
                        onPressed: () {
                          if (comment.text.isEmpty || rating == 0.0) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  "Please fill the comment section or rate the ${widget.isMovie == true ? "Series" : "Movie"}",
                                ),
                              ),
                            );
                            return;
                          }
                          addReview(widget.movieId, rating);
                          setState(() {
//

                            // add the value from this point

                            //
                            add = false;
                          });
                        },
                        child: const Text("Send"),
                      ),
                    ],
                  ),
                ),
              )
            : Container(
                constraints: const BoxConstraints(maxHeight: 700),
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  // physics: NeverScrollableScrollPhysics(),
                  itemCount: review["results"].length,
                  scrollBehavior: const ScrollBehavior(),
                  itemBuilder: (ctx, index) {
                    String originalDateString =
                        review["results"][index]["updated_at"];
                    DateTime originalDateTime =
                        DateTime.parse(originalDateString);

                    String formattedDate = formatDate(originalDateTime);
                    // print("no comments broooooo");
                    return Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(horizontal: 30),
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
                                    color:
                                        const Color.fromARGB(208, 241, 172, 98),
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
                              const Gap(10),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    review["results"][index]["author_details"]
                                        ["username"],
                                    style: GoogleFonts.poppins(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Container(
                                    width: 170,
                                    child: Text(
                                      review["results"][index]["author_details"]
                                          ["name"],
                                      style: GoogleFonts.poppins(),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  // Star(),
                                ],
                              ),
                              const Spacer(),
                              Text(formattedDate),
                            ],
                          ),
                          Container(
                            width: 400,
                            child: Text(
                              review["results"][index]["content"],
                              maxLines: 13,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.poppins(
                                height: 1.2,
                              ),
                            ),
                          ),
                          const Gap(20),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (contex) => CommShow(
                                            comment: review,
                                            indexw: index,
                                            format: formattedDate,
                                          )));
                            },
                            child: const Row(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.add_comment_rounded),
                                Gap(3),
                                Text(
                                  "See",
                                )
                              ],
                            ),
                          ),
                          const Gap(40)
                        ],
                      ),
                    );
                  },
                ),
              ),
      ],
    );
  }
}
