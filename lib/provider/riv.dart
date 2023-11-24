import 'package:riverpod/riverpod.dart';
import 'package:tmdb_api/tmdb_api.dart';

String apikey = "cf3e00ea296dc09f246e77b036845049";
String readaccesstoken =
    "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjZjNlMDBlYTI5NmRjMDlmMjQ2ZTc3YjAzNjg0NTA0OSIsInN1YiI6IjY1NGU1N2E1ZDQ2NTM3MDBhYjk1MWU4NyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.qPLTdMHqloyXvRf9QWKmH__NrlHNZmJZUziWkXJKo00";

final counterStatProvider = FutureProvider((ref) {
  return info();
});
Future<Map> info() async {
  TMDB tmdbWithCustomLogs = TMDB(
    ApiKeys(apikey, readaccesstoken),
    logConfig: const ConfigLogger(
      showLogs: true,
      showErrorLogs: true,
    ),
  );

  Map moviePopular = await tmdbWithCustomLogs.v3.movies.getPopular();

  return moviePopular;
}

// detail of the movies specifically

final movieDetailSp = FutureProvider.family<Map, int>((ref, movieId) {
  return movieDetail(movieId);
});

Future<Map> movieDetail(int movieId) async {
  TMDB tmdbWithCustomLogs = TMDB(
    ApiKeys(apikey, readaccesstoken),
    logConfig: const ConfigLogger(
      showLogs: true,
      showErrorLogs: true,
    ),
  );

  Map movieDetail = await tmdbWithCustomLogs.v3.movies.getDetails(movieId);

  return movieDetail;
}

// movie cast but not workable on tvcast

final movieCast = FutureProvider.family<Map, int>((ref, movieId) {
  return moviecast(movieId);
});

Future<Map> moviecast(int movieId) async {
  TMDB tmdbWithCustomLogs = TMDB(
    ApiKeys(apikey, readaccesstoken),
    logConfig: const ConfigLogger(
      showLogs: true,
      showErrorLogs: true,
    ),
  );

  Map movieCast = await tmdbWithCustomLogs.v3.movies.getCredits(movieId);

  return movieCast;
}

//  i can have some genre info through the genre

final genere = FutureProvider((ref) {
  return genereNum();
});

Future<Map> genereNum() async {
  TMDB tmdbWithCustomLogs = TMDB(
    ApiKeys(apikey, readaccesstoken),
    logConfig: const ConfigLogger(
      showLogs: true,
      showErrorLogs: true,
    ),
  );

  Map genere = await tmdbWithCustomLogs.v3.genres.getMovieList();

  // You can use the parameter s in your function

  return genere;
}

//  detail of the perticular person only and there more movies info

final personws = FutureProvider.family<Map, int>((ref, personId) {
  return personF(personId);
});

Future<Map> personF(int personId) async {
  TMDB tmdbWithCustomLogs = TMDB(
    ApiKeys(apikey, readaccesstoken),
    logConfig: const ConfigLogger(
      showLogs: true,
      showErrorLogs: true,
    ),
  );

  Map person = await tmdbWithCustomLogs.v3.people.getDetails(personId);

  return person;
}

// RECOMMNEDATION FOR THE MOVIE

final recommend = FutureProvider.family<Map, int>((ref, movieId) {
  return recommended(movieId);
});

Future<Map> recommended(int movieId) async {
  TMDB tmdbWithCustomLogs = TMDB(
    ApiKeys(apikey, readaccesstoken),
    logConfig: const ConfigLogger(
      showLogs: true,
      showErrorLogs: true,
    ),
  );

  Map recommend = await tmdbWithCustomLogs.v3.movies.getRecommended(movieId);
  print('Value of s: $movieId');
  // print("API Response: $recommend");

  return recommend;
}

// here the review of the movie can display

final reviewMovie = FutureProvider.family<Map, int>((ref, movieId) {
  return review(movieId);
});

Future<Map> review(int movieId) async {
  TMDB tmdbWithCustomLogs = TMDB(
    ApiKeys(apikey, readaccesstoken),
    logConfig: const ConfigLogger(
      showLogs: true,
      showErrorLogs: true,
    ),
  );

  Map reviewFTP = await tmdbWithCustomLogs.v3.movies.getReviews(movieId);
  // print("API Response: $recommend");

  return reviewFTP;
}

// here the similar of the movie can display

final similarMovie = FutureProvider.family<Map, int>((ref, movieId) {
  return similarw(movieId);
});

Future<Map> similarw(int movieId) async {
  TMDB tmdbWithCustomLogs = TMDB(
    ApiKeys(apikey, readaccesstoken),
    logConfig: const ConfigLogger(
      showLogs: true,
      showErrorLogs: true,
    ),
  );

  Map similar = await tmdbWithCustomLogs.v3.movies.getSimilar(movieId);
  // print("API Similar: $similar");

  return similar;
}

//////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////

//////////////////////TV SECTION//////////////////////////////

final tvDetailSp = FutureProvider.family<Map, int>((ref, movieId) {
  return tvDetail(movieId);
});

Future<Map> tvDetail(int tvId) async {
  TMDB tmdbWithCustomLogs = TMDB(
    ApiKeys(apikey, readaccesstoken),
    logConfig: const ConfigLogger(
      showLogs: true,
      showErrorLogs: true,
    ),
  );

  Map tvDetailSp = await tmdbWithCustomLogs.v3.tv.getDetails(tvId);

  return tvDetailSp;
}

final tvCast = FutureProvider.family<Map, int>((ref, tvId) {
  return tvCasts(tvId);
});

Future<Map> tvCasts(int tvId) async {
  TMDB tmdbWithCustomLogs = TMDB(
    ApiKeys(apikey, readaccesstoken),
    logConfig: const ConfigLogger(
      showLogs: true,
      showErrorLogs: true,
    ),
  );

  Map tvCast = await tmdbWithCustomLogs.v3.tv.getCredits(tvId);

  return tvCast;
}

final recommendtv = FutureProvider.family<Map, int>((ref, movieId) {
  return recommendwd(movieId);
});

Future<Map> recommendwd(int movieId) async {
  TMDB tmdbWithCustomLogs = TMDB(
    ApiKeys(apikey, readaccesstoken),
    logConfig: const ConfigLogger(
      showLogs: true,
      showErrorLogs: true,
    ),
  );

  // print(movieId);
  Map recommendtv = await tmdbWithCustomLogs.v3.tv.getRecommendations(movieId);
  // print("API Response: $recommendtv");

  return recommendtv;
}

// here the similar of the movie can display

final similarTv = FutureProvider.family<Map, int>((ref, movieId) {
  return similardw(movieId);
});

Future<Map> similardw(int movieId) async {
  TMDB tmdbWithCustomLogs = TMDB(
    ApiKeys(apikey, readaccesstoken),
    logConfig: const ConfigLogger(
      showLogs: true,
      showErrorLogs: true,
    ),
  );

  Map similarTv = await tmdbWithCustomLogs.v3.tv.getSimilar(movieId);
  // print("API Response: $similarTv");

  return similarTv;
}

// here the similar of the movie can display

final reviewTv = FutureProvider.family<Map, int>((ref, movieId) {
  return reviewFRG(movieId);
});

Future<Map> reviewFRG(int movieId) async {
  TMDB tmdbWithCustomLogs = TMDB(
    ApiKeys(apikey, readaccesstoken),
    logConfig: const ConfigLogger(
      showLogs: true,
      showErrorLogs: true,
    ),
  );

  Map reviewTv = await tmdbWithCustomLogs.v3.tv.getReviews(movieId);

  // print("API Response: $reviewTv"

  return reviewTv;
}

final videoMovie = FutureProvider.family<Map, int>((ref, movieId) {
  return movieVid(movieId);
});

Future<Map> movieVid(int movieId) async {
  TMDB tmdbWithCustomLogs = TMDB(
    ApiKeys(apikey, readaccesstoken),
    logConfig: const ConfigLogger(
      showLogs: true,
      showErrorLogs: true,
    ),
  );

  Map videoMovie = await tmdbWithCustomLogs.v3.movies.getVideos(movieId);

  // print("API Response: $reviewTv"

  return videoMovie;
}

final videoTv = FutureProvider.family<Map, String>((ref, movieId) {
  return tvVid(movieId);
});

Future<Map> tvVid(String movieId) async {
  TMDB tmdbWithCustomLogs = TMDB(
    ApiKeys(apikey, readaccesstoken),
    logConfig: const ConfigLogger(
      showLogs: true,
      showErrorLogs: true,
    ),
  );

  Map videoTv = await tmdbWithCustomLogs.v3.tv.getVideos(movieId);

  // print("API Response: $reviewTv"

  return videoTv;
}
