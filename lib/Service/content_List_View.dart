import 'package:cinema/Service/youtube.dart';
import 'package:cinema/provider/riv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ContentListView extends ConsumerStatefulWidget {
  ContentListView(
      {super.key, required this.contentId, required this.isTvMovie});

  int contentId;

  bool isTvMovie;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ContentListViewState();
}

class _ContentListViewState extends ConsumerState<ContentListView> {
  int contentID = 0;

  @override
  void initState() {
    // TODO: implement initState
    contentID = widget.contentId;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final contentInfo = ref.watch(videoMovie(contentID));
    final contentInfoTv = ref.watch(videoTv(contentID.toString()));

    final Map detailMovie;

    if (widget.isTvMovie == true) {
      detailMovie = contentInfoTv.when(
        data: (data) => data ?? {},
        loading: () => {},
        error: (error, stack) => {},
      );
    } else {
      detailMovie = contentInfo.when(
        data: (data) => data ?? {},
        loading: () => {},
        error: (error, stack) => {},
      );
    }
    int page = 1;
    int init = 1;
    late PageController _pageController = PageController(initialPage: 1);

    @override
    void initState() {
      super.initState();
      _pageController = PageController();
    }

    @override
    void dispose() {
      _pageController.dispose();
      super.dispose();
    }

    void indicator(int init) {
      setState(() {
        page = init;
      });
    }

    void scrollToPage(int pageIndex) {
      _pageController.jumpToPage(pageIndex);
      // Alternatively, you can use _pageController.animateToPage(pageIndex, duration: Duration(milliseconds: 500), curve: Curves.ease);
    }

    if (detailMovie == null || detailMovie["results"] == null) {
      return CircularProgressIndicator();
    }
    int r = (detailMovie["results"] as List<dynamic>?)?.length ?? 0;
    return Column(
      children: [
        Container(
          height: 400,
          child: PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            itemCount: (detailMovie["results"] as List<dynamic>?)?.length ?? 0,
            itemBuilder: (context, index) {
              return Center(
                child: Container(
                  height: 400,
                  child: MyVideoPlayer(
                    id: "${detailMovie["results"][index]["key"].toString()}",
                  ),
                ),
              );
            },
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (init < r && init >= 1)
                    setState(() {
                      init -= 1;

                      scrollToPage(init);
                      indicator(init);
                    });
                },
                child: Text("Previous "),
              ),
              Text("$init/$r"),
              ElevatedButton(
                  onPressed: () {
                    if (init < r)
                      setState(() {
                        init += 1;

                        scrollToPage(init);
                        indicator(init);
                      });
                  },
                  child: Text("Next")),
            ],
          ),
        )
      ],
    );
  }
}
