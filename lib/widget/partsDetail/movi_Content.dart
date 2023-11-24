import 'package:flutter/material.dart';

class MovieContent extends StatelessWidget {
  const MovieContent({
    super.key,
    required this.detailMovie,
  });

  final Map detailMovie;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Movie",
                style: TextStyle(fontSize: 20, color: Colors.amber[900]),
              ),
              const Spacer(),
              if (detailMovie != null) ...[
                if (detailMovie["status"] != null &&
                    detailMovie["release_date"] != null)
                  Text(
                    "${detailMovie["status"]}:${detailMovie["release_date"]}",
                    style: const TextStyle(
                      color: Color.fromARGB(255, 68, 68, 68),
                      fontWeight: FontWeight.w700,
                    ),
                  )
                else if (detailMovie["release_date"] == null)
                  Text(
                    "${detailMovie["status"]}",
                    style: const TextStyle(
                      color: Color.fromARGB(255, 68, 68, 68),
                      fontWeight: FontWeight.w700,
                    ),
                  )
                else if (detailMovie["dates"] != null &&
                    detailMovie["dates"]["maximum"] != null)
                  Text(
                    "Released Date:${detailMovie["dates"]["maximum"]}",
                    style: const TextStyle(
                      color: Color.fromARGB(255, 126, 126, 126),
                    ),
                  )
                else
                  const Text(
                    "Released Date: -- ",
                    style: TextStyle(color: Color.fromARGB(255, 29, 29, 29)),
                  ),
              ],
            ],
          ),

          Text(
            detailMovie["tagline"] != null
                ? "${detailMovie["tagline"]}"
                : "---------------",
            style: TextStyle(color: Colors.amber[900]),
          ),
          detailMovie["overview"] != null
              ? Text("${detailMovie["overview"]}")
              : const Text("---"),

          Row(
            children: [
              (detailMovie["genres"] != null &&
                      detailMovie["genres"].isNotEmpty)
                  ? Text(
                      "${detailMovie["genres"].map((genre) => genre["name"]).join(', ')}",
                      style: TextStyle(color: Colors.amber[900]),
                    )
                  : Text("------"),
              Spacer(),
              detailMovie["original_language"] != null
                  ? Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 2, vertical: 2),
                      padding: const EdgeInsets.symmetric(
                          vertical: 2, horizontal: 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              color: Color.fromARGB(255, 7, 255, 36),
                              width: 1)),
                      child: Text(
                        "lang: ${detailMovie["original_language"]}",
                      ),
                    )
                  : const Text("---"),
            ],
          )

          // Now, you can use RichText to display the TextSpans
        ],
      ),
    );
  }
}
