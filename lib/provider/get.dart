// review detail showm
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:cinema/class/person.dart';
import 'package:cinema/class/session_info.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tmdb_api/tmdb_api.dart';

String _apiKey = "cf3e00ea296dc09f246e77b036845049";
String _readaccesstoken =
    "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjZjNlMDBlYTI5NmRjMDlmMjQ2ZTc3YjAzNjg0NTA0OSIsInN1YiI6IjY1NGU1N2E1ZDQ2NTM3MDBhYjk1MWU4NyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.qPLTdMHqloyXvRf9QWKmH__NrlHNZmJZUziWkXJKo00";

TMDB tmdbWithCustomLogs = TMDB(
  ApiKeys(_apiKey, _readaccesstoken),
  logConfig: const ConfigLogger(
    showLogs: true,
    showErrorLogs: true,
  ),
);
// account details

// ////////////////////////////////////////////////////////////////////////////////

class PersonDataNotifier extends StateNotifier<List<PersonInfo>> {
  PersonDataNotifier() : super([]);

  void getDataFromState(personInfo) {
    print(personInfo);
    final meal = state.contains(personInfo);
    if (!meal) {}
    state = [...state, personInfo];
  }
}

final personDetailProvider =
    StateNotifierProvider<PersonDataNotifier, List<PersonInfo>>((ref) {
  return PersonDataNotifier();
});

// ////////////////////////////////////////////////////////////////////////////////

// get see person ACounts details

final sessionDetailProvider = StateNotifierProvider(
  (ref) {
    return SessionAccountDetailNotifier();
  },
);

class SessionAccountDetailNotifier extends StateNotifier<SessionInfo?> {
  SessionAccountDetailNotifier() : super(null) {
    // Load data from local storage on initialization
    _loadData();
  }

  Future<void> _loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? storedData = prefs.getString('sessionData');

    if (storedData != null) {
      SessionInfo sessionInfo = SessionInfo.fromJson(
        Map<String, dynamic>.from(json.decode(storedData)),
      );
      state = sessionInfo;
    }
  }

  Future<void> _saveData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    SessionInfo? sessionInfo = state;

    if (sessionInfo != null) {
      final jsonData = json.encode(sessionInfo.toJson());
      prefs.setString('sessionData', jsonData);
    }
  }

  void getSetSessionWork(SessionInfo personInfo) {
    print(personInfo);

    if (state == null) {
      state = personInfo;
      _saveData(); // Save data to local storage when it's modified
    }
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////

Future<SessionInfo?> _loadData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final List<String>? storedData = prefs.getStringList('sessionData');

  if (storedData != null && storedData.isNotEmpty) {
    final jsonData = storedData.first;
    final sessionInfo = SessionInfo.fromJson(
      Map<String, dynamic>.from(json.decode(jsonData)),
    );
    return sessionInfo;
  }

  return null; // Return null when there is no data
}

final sessionLoading = FutureProvider<Map<String, dynamic>>((ref) async {
  final SessionInfo? sessionInfo = await _loadData();

  if (sessionInfo != null) {
    // Convert single SessionInfo to Map<String, dynamic>
    final Map<String, dynamic> sessionInfoMap = {
      '${sessionInfo.accountId}': sessionInfo.toJson(),
    };

    return sessionInfoMap;
  } else {
    // Return an empty map if no data is available
    return {};
  }
});

// ///////////////////////////////////////////////////////////////////////////////

// when to watch the data
// final instance = ref.watch(personDetailProvider);

// to insert the value in state
// ref.read(personDetailProvider.notifier).getDatFromState(data);

///////////////////////////////////////////////////////////////////////////////////

// this will return me all the info

Future<List<dynamic>> account(List accountInfo) async {
//  here i want all the info for the person login work
  return [];
}

final reviewDetail = FutureProvider.family<Map, int>((ref, movieId) {
  return reviewd(movieId);
});

Future<Map> reviewd(int movieId) async {
  TMDB tmdbWithCustomLogs = TMDB(
    ApiKeys(_apiKey, _readaccesstoken),
    logConfig: const ConfigLogger(
      showLogs: true,
      showErrorLogs: true,
    ),
  );

  Map reviewTv = await tmdbWithCustomLogs.v3.tv.getReviews(movieId);

  // print("API Response: $reviewTv");

  return reviewTv;
}

final revieWM = FutureProvider.family<Map, List>((ref, list) {
  return revieAdd(list[0], list[1]);
});

Future<Map> revieAdd(double movieId, double ratingValue) async {
  TMDB tmdbWithCustomLogs = TMDB(
    ApiKeys(_apiKey, _readaccesstoken),
    logConfig: const ConfigLogger(
      showLogs: true,
      showErrorLogs: true,
    ),
  );
  final make = movieId.toInt();
  Map reviewAdd = await tmdbWithCustomLogs.v3.movies.rateMovie(
    make,
    ratingValue,
  );
  // print("API Response: $reviewTv");

  return reviewAdd;
}

final watchMovie = FutureProvider.family<void, List>((ref, list) {
  // print("points:$list");
  return reviewe(list[0], list[1], list[2], list[3]);
});

Future<void> reviewe(
    int accountId, String sessionId, int movieId, bool ismovie) async {
  TMDB tmdbWithCustomLogs = TMDB(
    ApiKeys(_apiKey, _readaccesstoken),
    logConfig: const ConfigLogger(
      showLogs: true,
      showErrorLogs: true,
    ),
  );

  Map reviewAdd;

  ismovie == false
      ? tmdbWithCustomLogs.v3.account
          .addToWatchList(sessionId, accountId, movieId, MediaType.movie)
      : tmdbWithCustomLogs.v3.account
          .addToWatchList(sessionId, accountId, movieId, MediaType.tv);
  // print("API Response: $reviewTv");
}

final watchDetail = FutureProvider.family<Map, List>((ref, list) {
  // print("points:$list");
  return reviewe3(list[0], list[1], list[2], list[3]);
});

Future<Map> reviewe3(
    int accountId, String sessionId, int movieId, bool ismovie) async {
  TMDB tmdbWithCustomLogs = TMDB(
    ApiKeys(_apiKey, _readaccesstoken),
    logConfig: const ConfigLogger(
      showLogs: true,
      showErrorLogs: true,
    ),
  );

  

  Map reviewAdd = {};

  ismovie == false
      ? tmdbWithCustomLogs.v3.account.getMovieWatchList(
          sessionId,
          accountId,
        )
      : tmdbWithCustomLogs.v3.account.getTvShowWatchList(sessionId, accountId);
  // print("API Response: $reviewTv");

  return reviewAdd;
}
