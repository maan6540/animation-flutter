import 'dart:math';

import 'package:flutter/material.dart';

class homepage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _homepageState();
  }
}

// ignore: camel_case_types
class _homepageState extends State<homepage>
    with SingleTickerProviderStateMixin {
  double _buttonRadius = 100;
  double _buttonRadiusB = 100;
  double _vertical = 100;
  double _horizontal = 200;

  final Tween<double> _backgroundScale = Tween<double>(begin: 0.0, end: 1.0);

  AnimationController? _starIconAnimationController;

  @override
  void initState() {
    super.initState();
    _starIconAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 2,
      ),
    );
    _starIconAnimationController!.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            _pageBackground(),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _circularAnimationButtonBottom(),
                _circularAnimationButton(),
                _starIcon(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _pageBackground() {
    return TweenAnimationBuilder(
        curve: Curves.fastOutSlowIn,
        tween: _backgroundScale,
        duration: const Duration(seconds: 1),
        builder: (context, double scale, child) {
          return Transform.scale(
            scale: scale,
            child: child,
          );
        },
        child: Container(
          color: const Color.fromARGB(255, 85, 223, 138),
        ));
  }

  Widget _circularAnimationButton() {
    return Center(
      child: GestureDetector(
        onTap: () {
          setState(() {
            // _buttonRadius == 200 ? _buttonRadius = 100 : _buttonRadius = 200;
            _buttonRadius += _buttonRadius == 200 ? -100 : 100;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(seconds: 4),
          curve: Curves.bounceIn,
          width: _buttonRadius,
          height: _buttonRadius,
          decoration: BoxDecoration(
              color: Colors.blue, borderRadius: BorderRadius.circular(100)),
          child: const Center(
            child: Text(
              "Basic",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget _circularAnimationButtonBottom() {
    return Container(
      margin: EdgeInsets.only(left: _vertical, top: _horizontal),
      child: GestureDetector(
        onDoubleTap: () {
          setState(() {
            // _buttonRadius == 200 ? _buttonRadius = 100 : _buttonRadius = 200;
            _buttonRadiusB += _buttonRadiusB == 200 ? -100 : 100;
            _horizontal += _horizontal == 200 ? -100 : 100;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(seconds: 3),
          width: _buttonRadiusB,
          height: _buttonRadiusB,
          decoration: BoxDecoration(
              color: Colors.black, borderRadius: BorderRadius.circular(100)),
        ),
      ),
    );
  }

  Widget _starIcon() {
    return AnimatedBuilder(
      animation: _starIconAnimationController!.view,
      builder: (_buildContext, _child) {
        return Transform.rotate(
          angle: _starIconAnimationController!.value * 2 * pi,
          child: _child,
        );
      },
      child: const Icon(
        Icons.star,
        size: 100,
        color: Colors.white,
      ),
    );
  }
}
