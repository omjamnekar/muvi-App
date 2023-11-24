import 'package:cinema/class/session_info.dart';
import 'package:cinema/provider/get.dart';
import 'package:cinema/screens/fav/seeWatchList.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IconWork extends ConsumerStatefulWidget {
  const IconWork({
    super.key,
    required this.movieId,
    required this.isTvMovie,
  });

  final int movieId;
  final bool isTvMovie;

  @override
  ConsumerState<IconWork> createState() => _IconWorkState();
}

class _IconWorkState extends ConsumerState<IconWork> {
  @override
  Widget build(BuildContext context) {
    watchMovied(int movieId, List sessionData) async {
      print("sessoion ${sessionData[0].runtimeType}");
      print("sessoion ${sessionData[1].runtimeType}");

      ref.watch(watchMovie([
        sessionData[0],
        sessionData[1],
        movieId,
        widget.isTvMovie,
      ]));
    }

    final sessionDetail = ref.watch(sessionDetailProvider) as SessionInfo?;

    // here the sessiondata will be provided to the watchlist

    List sesssionData = [];
    List watchData = [];

    if (sessionDetail != null) {
      // Access properties of SessionInfo
      sesssionData = [sessionDetail.accountId, sessionDetail.sessionId];
      watchData = [
        sesssionData[0],
        sesssionData[1],
        widget.movieId,
        widget.isTvMovie
      ];
    } else {
      // Handle the case where sessionDetail is null (no data)
      print('No session detail available');
    }

//     Map<String, dynamic> sessionInfoMap = {};

//     print("SessionInfoMap: $sessionInfoMap");

// // Access the loaded data outside of watchlist.when

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  watchMovied(widget.movieId, sesssionData);
                  print("done");

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SeeWatchList(seeData: watchData)));
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(163, 255, 111, 0),
                  ),
                  child: const Icon(
                    Icons.bookmark_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
              const Text(
                "WatchList",
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(163, 255, 111, 0),
                ),
                child: const Icon(
                  Icons.star,
                  color: Colors.white,
                ),
              ),
              const Text(
                "Add to List",
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(163, 255, 111, 0),
                ),
                child: const Icon(
                  Icons.list_alt_outlined,
                  color: Colors.white,
                ),
              ),
              const Text(
                "Rate It",
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(163, 255, 111, 0),
                ),
                child: const Icon(
                  Icons.favorite_outlined,
                  color: Colors.white,
                ),
              ),
              const Text(
                "Favorite",
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
