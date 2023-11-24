import 'package:flutter/material.dart';

class FullFrame extends StatefulWidget {
  FullFrame({super.key, required this.image});

  String image;

  @override
  State<FullFrame> createState() => _FullFrameState();
}

class _FullFrameState extends State<FullFrame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Hero(
        tag: "object",
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://image.tmdb.org/t/p/w500${widget.image}"))),
        ),
      ),
    );
  }
}
