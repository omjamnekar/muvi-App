import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class CheckLogin extends StatefulWidget {
  CheckLogin({
    super.key,
    required this.loginSection,
    required this.selected,
  });
  bool loginSection = false;
  // bool create;
  final void Function(bool ef, bool rt, bool cr, bool login) selected;

  @override
  State<CheckLogin> createState() => _CheckLoginState();
}

class _CheckLoginState extends State<CheckLogin> {
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
            border: Border.all(color: Color(0xFFff9505), width: 2),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            children: [
              Text(
                "Check Whether you have login or You can make it now",
                style: GoogleFonts.poppins(
                  letterSpacing: .01,
                  height: 1,
                  color: const Color.fromARGB(255, 255, 255, 255),
                  fontSize: 50,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Gap(50),
              Material(
                borderRadius: BorderRadius.circular(10),
                child: TextButton.icon(
                  onPressed: () {
                    setState(() {
                      widget.loginSection = false;
                    });

                    widget.selected(false, false, false, true);
                  },
                  icon: const Icon(
                    Icons.account_circle_rounded,
                    size: 50,
                  ),
                  label: Text("LOGIN",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      )),
                  style: const ButtonStyle(
                    padding: MaterialStatePropertyAll(
                      EdgeInsets.only(
                        top: 20,
                        bottom: 30,
                        left: 100,
                        right: 100,
                      ),
                    ),
                  ),
                ),
              ),
              const Gap(20),
              Text(
                "or",
                style: GoogleFonts.poppins(
                  letterSpacing: .01,
                  height: 1,
                  color: const Color.fromARGB(255, 255, 255, 255),
                  fontSize: 50,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Gap(20),
              Material(
                borderRadius: BorderRadius.circular(10),
                child: TextButton.icon(
                  onPressed: () {
                    setState(() {
                      widget.loginSection = false;
                    });

                    widget.selected(false, false, true, false);
                  },
                  icon: const Icon(
                    Icons.create_new_folder_outlined,
                    size: 50,
                  ),
                  label: Text("Create",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      )),
                  style: const ButtonStyle(
                    padding: MaterialStatePropertyAll(
                      EdgeInsets.only(
                        top: 30,
                        bottom: 30,
                        left: 100,
                        right: 100,
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
                        backgroundColor: MaterialStatePropertyAll(Colors.white),
                      ),
                      color: const Color.fromARGB(255, 118, 68, 255),
                      onPressed: () {
                        setState(() {
                          widget.loginSection = false;
                        });

                        widget.selected(true, false, false, false);
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
                      // setState(() {
                      //   widget.loginSection = false;
                      // });

                      // widget.selected(false, false),;
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
    );
  }
}
