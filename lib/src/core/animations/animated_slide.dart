import 'package:flutter/material.dart';

import 'animation_state.dart';

class AnimatedSlide extends StatefulWidget {
  final Widget child;
  final Direction direction;
  final Duration delay;
  final Duration animationDuration;

  const AnimatedSlide({
    super.key,
    required this.child,
    this.direction = Direction.bottom,
    this.delay = const Duration(milliseconds: 50),
    this.animationDuration = const Duration(milliseconds: 200),
  });

  @override
  State<AnimatedSlide> createState() => AnimatedSlideState(animationDuration);
}

class AnimatedSlideState extends AnimationControllerState<AnimatedSlide> {
  AnimatedSlideState(super.animationDuration);

  late final AnimationController _controllerFade;

  late final Animation<Offset> _offsetAnimation;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controllerFade = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);

    final (begin, end) = widget.direction.toOffsets();
    _offsetAnimation = Tween(begin: begin, end: end).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeOut),
    );
    _fadeAnimation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    Future<void>.delayed(widget.delay, () {
      if (!mounted) return;
      controller.forward();
      _controllerFade.forward();
    });
  }

  @override
  void dispose() {
    _controllerFade.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: widget.child,
      ),
    );
  }
}
