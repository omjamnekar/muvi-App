import 'package:cinema/Service/youtube.dart';

import 'package:cinema/screens/welcom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinema/screens/homePage.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //final s = ref.watch(counterStatProvider);
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue, // Color for app bars, etc.
        hintColor: const Color.fromARGB(
            255, 255, 231, 196), // Color for floating action buttons, etc.
        scaffoldBackgroundColor: const Color.fromARGB(
            255, 255, 245, 237), //, Background color for the app
        textTheme: TextTheme(
            // bodyText1: TextStyle(color: Colors.black), // Default text color
            // bodyText2: TextStyle(color: Colors.grey[700]),
            ),
        useMaterial3: true,
      ),

      // home: ShowData(),

      // home: CategoryDiscover(
      //   content: {},
      // ),
      home: HomePage(),
      // home: OnboardingScreen(),
      // home: const WelcomePage(),
      // home: MyVideoPlayer(
      //   id: 'Ca9fhpPbgOw',
      // ),
    );
  }
}


// #ffc971

// #ffb627

// #ff9505

// #e2711d

// #cc5803
