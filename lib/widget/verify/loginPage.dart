import 'package:cinema/class/person.dart';
import 'package:cinema/class/session_info.dart';
import 'package:cinema/provider/get.dart';
import 'package:cinema/screens/introPage.dart';
import 'package:cinema/screens/onBordInfo.dart';
import 'package:cinema/widget/custom/customD.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends ConsumerStatefulWidget {
  LoginPage({super.key, required this.send});

  final void Function(bool home, bool loginsection, bool login) send;

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  // Map user = {};
  // Map pass = {};

  bool _isAuthentication = false;

  var _userName = "";
  var _passWord = "";

  bool isSafe = false;

  final String _url = 'https://www.themoviedb.org/signup'; // Your desired URL

  Future<void> _launchURL() async {
    if (await canLaunch(_url)) {
      await launch(_url);
    } else {
      throw 'Could not launch $_url';
    }
  }

  _submit() async {
    // print(username.text);

    final isValid = _formKey.currentState!.validate();

    if (!isValid == null) {
      return;
    }

    _formKey.currentState!.save();

    try {
      setState(() {
        _isAuthentication = true;
      });
      const String _apiKey = "cf3e00ea296dc09f246e77b036845049";
      const String _readaccesstoken =
          "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjZjNlMDBlYTI5NmRjMDlmMjQ2ZTc3YjAzNjg0NTA0OSIsInN1YiI6IjY1NGU1N2E1ZDQ2NTM3MDBhYjk1MWU4NyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.qPLTdMHqloyXvRf9QWKmH__NrlHNZmJZUziWkXJKo00";

      TMDB tmdbWithCustomLogs = TMDB(
        ApiKeys(_apiKey, _readaccesstoken),
        logConfig: const ConfigLogger(
          showLogs: true,
          showErrorLogs: true,
        ),
      );
      Map requestToken = await tmdbWithCustomLogs.v3.auth
          .createSessionWithLogin(_userName, _passWord, asMap: true);

      final sessionId = await tmdbWithCustomLogs.v3.auth
          .createSession(requestToken["request_token"], asMap: true);
      final account_id = await tmdbWithCustomLogs.v3.account
          .getDetails(sessionId["session_id"]);

      setState(() {
        // print("Request Id:$requestToken");
        // print("session ID:$sessionId");
        // print("account ID:$account_id");
        _isAuthentication = false;

//////////////////////////data saving permant basis n mobile/////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////

        // user data
// data transfering to the state
        PersonInfo person =
            PersonInfo(personPassword: _passWord, personUsername: _userName);
        SessionInfo personSession = SessionInfo(
            accountId: account_id["id"],
            requestToken: requestToken["request_token"],
            sessionId: sessionId["session_id"]);
        ref.watch(personDetailProvider.notifier).getDataFromState(person);
        ref
            .watch(sessionDetailProvider.notifier)
            .getSetSessionWork(personSession);

        //  /////////////////////////////////
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OnboardingScreen(),
                    ));
              },
              child: CustomDialogBox(
                key: Key(AutofillHints.birthday),
                title: "Congrats ${account_id["username"]}",
                descriptions:
                    "you can now access movies, shows ,Top rated content ,Popular content and much more with out app! let's start",
                text: 'Enter',
                img: "assets/image/we.png",
                change: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => OnboardingScreen(),
                      ));
                },
              ),
            );
          },
        );
      });

      // setState(() {

      // });
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Text("your username or password is wrong,please see."),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Authentication goes wrong'),
                        content: Text(
                            'we didn\'t get your username and password seems like you haven\'t made it yet Or your forgot to validate your email Id tho.\n CodeError:$e'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text('cencel'),
                          ),
                          TextButton(
                            onPressed: _launchURL,
                            child: Text('SignUp'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Icon(Icons.help_outline_sharp),
              )
            ],
          ),
        ),
      );

      setState(() {
        _isAuthentication = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 400,
          height: 800,
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 220, 195),
            border: Border.all(color: const Color(0xFFff9505), width: 2),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Text(
                  "Login your account and Enjoy",
                  style: GoogleFonts.poppins(
                    letterSpacing: .01,
                    height: 1,
                    color: const Color.fromARGB(255, 255, 255, 255),
                    fontSize: 50,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Gap(100),
                TextFormField(
                  // controller: username,
                  decoration: InputDecoration(
                    labelText: "Username",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter username";
                    } else if (value.trim().contains(" ")) {
                      return 'username is not correct';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _userName = value!;
                  },
                ),
                const Gap(20),

                // here the password can be allocated
                TextFormField(
                  // controller: pass,
                  obscureText: !isSafe,
                  decoration: InputDecoration(
                    labelText: "Password",
                    suffixIcon: IconButton(
                        onPressed: () {
                          isSafe = !isSafe;
                        },
                        icon: isSafe
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter password";
                    } else if (value.trim().contains(" ")) {
                      return "Password is not correct";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _passWord = value!;
                  },
                ),

                const Gap(20),
                if (_isAuthentication) CircularProgressIndicator(),
                if (!_isAuthentication)
                  ElevatedButton.icon(
                    onPressed: _submit,
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          Color.fromARGB(255, 255, 255, 255)),
                      padding: MaterialStatePropertyAll(
                        EdgeInsets.only(
                          bottom: 20,
                          top: 20,
                          left: 130,
                          right: 130,
                        ),
                      ),
                    ),
                    label: const Text(
                      "Submit",
                      style: TextStyle(fontSize: 12),
                    ),
                    icon: const Icon(Icons.data_usage_rounded),
                  ),
                const Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        padding: const EdgeInsets.all(10),
                        style: const ButtonStyle(
                          alignment: Alignment.center,
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.white),
                        ),
                        color: const Color.fromARGB(255, 118, 68, 255),
                        onPressed: () {
                          setState(() {
                            widget.send(false, true, false);
                          });
                        },
                        icon: Container(
                          width: 60,
                          alignment: Alignment.center,
                          child: Transform.rotate(
                            angle: 3.2,
                            child: const Icon(
                              Icons.double_arrow_rounded,
                              size: 40,
                              // fill: Colors.amberAccent.opacity,
                            ),
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CustomDialogBox(
                                key: Key(AutofillHints.birthday),
                                title: "Muvi app",
                                descriptions:
                                    "you can see movies, shows ,Top rated content ,Popular content and much more",
                                text: 'OK',
                                img: "assets/image/we.png",
                                change: () => Navigator.pop(context),
                              );
                            },
                          );
                        },
                        child: Text("see")),
                    GestureDetector(
                      onTap: () {
                        // widget.selected = (ef) => ef = true;
                      },
                      child: const Text(
                        "Terms and Conditions",
                        style: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 178, 178, 178),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
