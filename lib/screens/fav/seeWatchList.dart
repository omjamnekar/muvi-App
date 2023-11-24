import 'package:cinema/provider/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SeeWatchList extends ConsumerStatefulWidget {
  SeeWatchList({super.key, required this.seeData});

  final List seeData;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SeeWatchListState();
}

class _SeeWatchListState extends ConsumerState<SeeWatchList> {
  Map seeDetail = {};
  seeWatchList() async {
    final sasas = ref.watch(watchDetail([
      widget.seeData[0],
      widget.seeData[1],
      widget.seeData[2],
      widget.seeData[3],
    ]));

    seeDetail = sasas.when(
      data: (data) => data ?? {},
      loading: () => {},
      error: (error, stack) => {},
    );
    print("Afvaf$seeDetail");
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    seeWatchList(); // TODO: implement initState
    return Scaffold(body: Container());
  }
}
