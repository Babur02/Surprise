import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';
import 'dart:async';
import 'main.dart';

// ignore: camel_case_types
class startingScreen extends StatefulWidget {
  const startingScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _startingScreenState createState() => _startingScreenState();
}

// ignore: camel_case_types
class _startingScreenState extends State<startingScreen> {
  var _controllerCenterRight = ConfettiController();
  ConfettiController _controllerCenterLeft = ConfettiController();

  Timer _timer = Timer(Duration.zero, () {});

  int _start = 5;
  void startTimer() {
    const oneSec = Duration(seconds: 2);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            _controllerCenterRight.play();
            _controllerCenterLeft.play();
            timer.cancel();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  @override
  void initState() {
    _controllerCenterRight =
        ConfettiController(duration: const Duration(seconds: 10));
    _controllerCenterLeft =
        ConfettiController(duration: const Duration(seconds: 10));
    super.initState();
    Future.delayed(const Duration(seconds: 11), () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _controllerCenterRight.dispose();
    _controllerCenterLeft.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    startTimer();
    return Scaffold(
      bottomNavigationBar: const SizedBox(
        height: 50,
        child: BottomAppBar(
          shape: CircularNotchedRectangle(),
          color: Colors.pinkAccent,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ));
        },
        backgroundColor: const Color(0xff13195b),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Column(
        children: <Widget>[
          ClipPath(
            clipper: WaveClipperTwo(),
            child: Container(
              height: 220,
              //  color: Colors.pinkAccent,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  _start.toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.w900, fontSize: 50),
                )),
          ),
          Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.centerRight,
                child: ConfettiWidget(
                  confettiController: _controllerCenterRight,
                  blastDirection: pi, // radial value - LEFT
                  particleDrag: 0.05, // apply drag to the confetti
                  emissionFrequency: 0.05, // how often it should emit
                  numberOfParticles: 20, // number of particles to emit
                  gravity: 0.05, // gravity - or fall speed
                  shouldLoop: false,
                  colors: const [
                    Colors.green,
                    Colors.blue,
                    Colors.pink
                  ], // manually specify the colors to be used
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: ConfettiWidget(
                  confettiController: _controllerCenterLeft,
                  blastDirection: 0, // radial value - RIGHT
                  emissionFrequency: 0.6,
                  minimumSize: const Size(10,
                      10), // set the minimum potential size for the confetti (width, height)
                  maximumSize: const Size(50,
                      50), // set the maximum potential size for the confetti (width, height)
                  numberOfParticles: 1,
                  gravity: 0.1,
                ),
              ),
              if (_start == 0)
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5.0, left: 20),
                      child: FittedBox(
                        child: Text(
                          "Happiee \nBirthday \[Name]🎉",
                          style: TextStyle(
                              color: Color(0xff13195b),
                              fontWeight: FontWeight.w900,
                              fontSize: 90),
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}
