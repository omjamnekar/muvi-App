import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:multiuserapp/imageList.dart';

class SliderMethod extends StatelessWidget {
  final Map imageList;

  SliderMethod({Key? key, required this.imageList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: CarouselSlider(
        items: imageList['results']!.map<Widget>((e) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.1),
                    BlendMode.darken,
                  ),
                  child: Image.network(
                    "https://image.tmdb.org/t/p/w500" +
                        (e['backdrop_path'] ?? ''),
                    width: 1450,
                    height: 550,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
        options: CarouselOptions(
          enlargeCenterPage: true,
          enableInfiniteScroll: false,
          autoPlay: true,
        ),
      ),
    );
  }
}
