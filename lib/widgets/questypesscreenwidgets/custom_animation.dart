import 'dart:async';
import 'package:flutter/material.dart';

class CustomAnimation extends StatefulWidget {
  final int addTime;
  final Widget child;

  const CustomAnimation({this.addTime = 800, required this.child, Key? key})
      : super(key: key);

  @override
  State<CustomAnimation> createState() => _CustomAnimationState();
}

class _CustomAnimationState extends State<CustomAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slideAnimation;
  late Animation<double> opacity;

  @override
  void initState() {
    animationController = AnimationController(
        vsync: this, duration: const Duration(seconds: 1));
    slideAnimation = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
        .animate(CurvedAnimation(
            parent: animationController, curve: Curves.decelerate));
    opacity = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(
        parent: animationController, curve: Curves.decelerate));

    animationController.addListener(() {
      setState(() {
        startAnimtion();
      });
    });
    startAnimtion();

    super.initState();
  }

  void startAnimtion() {
    int defaultDuration=widget.addTime==0?800:widget.addTime;
    Timer(Duration(milliseconds: defaultDuration), ()  {
      animationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
        duration: const Duration(milliseconds: 800),
        opacity: opacity.value,
        child: SlideTransition(
          position: slideAnimation,
          child: widget.child,
        ));
  }
}
