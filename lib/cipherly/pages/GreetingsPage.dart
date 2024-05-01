import 'package:cipherly/cipherly/pages/SetMasterPassword.dart';
import 'package:cipherly/host%20manager/screens/main_screen/main_screen.dart';
import 'package:flutter/material.dart';

class GreetingsPage extends StatefulWidget {
  @override
  _GreetingsPageState createState() => _GreetingsPageState();
}

class _GreetingsPageState extends State<GreetingsPage> {
  @override
  Widget build(BuildContext context) {
    Color primaryColor = Theme.of(context).primaryColor;
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(seconds: 3),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/key.png",
                height: size.height * 0.3,
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(24.0, 8, 24, 8),
                child: Text("Welcome to Cipherly!",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: "Title", fontSize: 36)),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(24.0, 8, 24, 8),
                child: Text(
                  "Cipherly takes care of your sensitive password data using AES encryption.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Subtitle",
                    fontSize: 18,
                    // color: Colors.black54
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(24.0, 8, 24, 8),
                child: Text("Set your master password to get started!",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: "Subtitle", fontSize: 24)),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(24.0, 8, 24, 8),
                child: Text(
                  "(You can change it afterwards)",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Subtitle",
                    fontSize: 18,
                    // color: Colors.black54
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  SizedBox(
                    height: 60,
                    width: size.width * 0.7,
                    child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32)),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      SetMasterPassword()));
                        },
                        color: primaryColor,
                        child: const Text("Get Started",
                            style: TextStyle(color: Colors.white))),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 60,
                    width: size.width * 0.7,
                    child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32)),
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const MainScreen()));
                        },
                        color: primaryColor,
                        child: const Text("Host Manager",
                            style: TextStyle(color: Colors.white))),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
