import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged/supercharged.dart';

enum AniProps { opacity, translateX }

class FadeAnimation extends StatelessWidget {
  FadeAnimation({this.delay, this.child});

  final double delay;
  final Widget child;

  final _tween = MultiTween<AniProps>()
    ..add(AniProps.opacity, 0.0.tweenTo(1.0), 400.milliseconds)
    ..add(AniProps.translateX, 60.0.tweenTo(0.0), 400.milliseconds);

  @override
  Widget build(BuildContext context) {
    return PlayAnimation<MultiTweenValues>(
      delay: Duration(
        milliseconds: (400 * delay).round(),
      ),
      duration: _tween.duration,
      tween: _tween,
      child: child,
      builder: (context, child, value) => Opacity(
        opacity: value.get(AniProps.opacity),
        child: Transform.translate(
          offset: Offset(value.get(AniProps.translateX), 0),
          child: child,
        ),
      ),
    );
  }
}
