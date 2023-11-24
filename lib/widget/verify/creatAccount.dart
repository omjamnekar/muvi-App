import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class CreatAccount extends StatefulWidget {
  CreatAccount({super.key, required this.send});

  // bool _createAcc = false;
  final void Function(bool back, bool login, bool create) send;

  @override
  State<CreatAccount> createState() => _CreatAccountState();
}

class _CreatAccountState extends State<CreatAccount> {
  final String _url = 'https://www.themoviedb.org/signup'; // Your desired URL

  Future<void> _launchURL() async {
    if (await canLaunch(_url)) {
      await launch(_url);
    } else {
      throw 'Could not launch $_url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
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
            child: Column(
              children: [
                Text(
                  "From here you can make your Account",
                  style: GoogleFonts.poppins(
                    letterSpacing: .01,
                    height: 1,
                    color: const Color.fromARGB(255, 255, 255, 255),
                    fontSize: 50,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const Gap(50),
                const Gap(20),
                Material(
                  borderRadius: BorderRadius.circular(10),
                  child: TextButton.icon(
                    onPressed: _launchURL,
                    icon: const Icon(
                      Icons.create_new_folder_outlined,
                      size: 50,
                    ),
                    label: Text("Create from link",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        )),
                    style: const ButtonStyle(
                      padding: MaterialStatePropertyAll(
                        EdgeInsets.only(
                          top: 30,
                          bottom: 30,
                          left: 50,
                          right: 50,
                        ),
                      ),
                    ),
                  ),
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
                    GestureDetector(
                      onTap: () {
                        // widget.selected = (ef) => ef = true;
                      },
                      child: const Text(
                        "Terms and Conditions",
                        style: TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 178, 178, 178),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
