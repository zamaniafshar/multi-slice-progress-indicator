import 'dart:async';
import 'package:flutter/material.dart';
import 'progress_indicator_status.dart';
import 'widgets/progress_indicator_painter.dart';

class MultiSliceProgressIndicator extends StatefulWidget {
  const MultiSliceProgressIndicator({
    Key? key,
    required this.radius,
    required this.status,
    required this.successColors,
    required this.failColors,
    required this.inActiveColors,
    this.startDeg = 90,
  }) : super(key: key);

  final double radius;
  final ProgressIndicatorStatus status;
  final List<Color> successColors;
  final List<Color> failColors;
  final List<Color> inActiveColors;
  final double startDeg;

  @override
  State<MultiSliceProgressIndicator> createState() => _MultiSliceProgressIndicatorState();
}

class _MultiSliceProgressIndicatorState extends State<MultiSliceProgressIndicator>
    with TickerProviderStateMixin {
  late final AnimationController controller1;
  late final AnimationController controller2;
  late final AnimationController controller3;
  late Completer animationCompleter = Completer();
  late List<Color> currentColors = getProgressColors;
  late List<Color> previousColors = getProgressColors;
  bool isAnimating = false;
  bool isAnimatingColors = false;

  @override
  void didUpdateWidget(covariant MultiSliceProgressIndicator oldWidget) {
    if (oldWidget.status != widget.status) {
      animate(oldWidget.status);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    controller1 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    controller2 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    controller3 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    controller3.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed && widget.status.isStart) {
          animate();
        }
      },
    );
    animate();
    super.initState();
  }

  Future<void> animate([ProgressIndicatorStatus? oldStatus]) async {
    if (isAnimating) {
      await animationCompleter.future;
    }
    if (animationCompleter.isCompleted) {
      animationCompleter = Completer();
    }

    isAnimating = true;
    if (currentColors != getProgressColors) {
      await animateBetweenColors();
    }
    if (widget.status.isStart) {
      await startAnimation();
    } else if (widget.status.isReverse) {
      await reverseAnimation();
    } else if (widget.status.isCancel) {
      cancelAnimation();
    }
    isAnimating = false;

    if (!animationCompleter.isCompleted) {
      animationCompleter.complete();
    }
  }

  Future<void> startAnimation() async {
    controller1.forward(from: 0.0);
    await Future.delayed(const Duration(milliseconds: 250));
    controller2.forward(from: 0.0);
    await Future.delayed(const Duration(milliseconds: 250));
    await controller3.forward(from: 0.0);
  }

  Future<void> animateBetweenColors() async {
    previousColors = currentColors;
    currentColors = getProgressColors;
    isAnimatingColors = true;
    cancelAnimation();
    await startAnimation();
    isAnimatingColors = false;
  }

  Future<void> reverseAnimation() async {
    controller1.reverse(from: 1.0);
    await Future.delayed(const Duration(milliseconds: 250));
    controller2.reverse(from: 1.0);
    await Future.delayed(const Duration(milliseconds: 250));
    await controller3.reverse(from: 1.0);
  }

  void cancelAnimation() {
    controller1.stop();
    controller1.reset();
    controller2.stop();
    controller2.reset();
    controller3.stop();
    controller3.reset();
  }

  double get shaderDeg1 => (isAnimatingColors ? 0.0 : controller1.value * 360) + widget.startDeg;
  double get shaderDeg2 => (isAnimatingColors ? 0.0 : controller2.value * 360) + widget.startDeg;
  double get shaderDeg3 => (isAnimatingColors ? 0.0 : controller3.value * 360) + widget.startDeg;

  List<Color> getAnimatedColors(AnimationController controller) {
    if (!isAnimatingColors) return currentColors;

    final List<Color> newColors = [];
    for (var i = 0; i < previousColors.length; i++) {
      final newColor = Color.lerp(previousColors[i], currentColors[i], controller.value);
      newColors.add(newColor!);
    }
    return newColors;
  }

  List<Color> get getProgressColors {
    if (widget.status.isSucceed) {
      return widget.successColors;
    } else if (widget.status.isFail) {
      return widget.failColors;
    } else {
      return widget.inActiveColors;
    }
  }

  @override
  Widget build(BuildContext context) {
    final radius1 = widget.radius / 3;
    final radius2 = radius1 + widget.radius / 3;
    final radius3 = radius2 + widget.radius / 3;

    return SizedBox.square(
      dimension: widget.radius * 2,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: controller3,
            builder: (context, _) {
              return CustomPaint(
                painter: SliceProgressIndicatorPainter(
                  colors: getAnimatedColors(controller3),
                  radius: radius3,
                  shaderDeg: shaderDeg3,
                ),
              );
            },
          ),
          AnimatedBuilder(
            animation: controller2,
            builder: (context, _) {
              return CustomPaint(
                painter: SliceProgressIndicatorPainter(
                  colors: getAnimatedColors(controller2),
                  radius: radius2,
                  shaderDeg: shaderDeg2,
                ),
              );
            },
          ),
          AnimatedBuilder(
            animation: controller1,
            builder: (context, _) {
              return CustomPaint(
                painter: SliceProgressIndicatorPainter(
                  colors: getAnimatedColors(controller1),
                  radius: radius1,
                  shaderDeg: shaderDeg1,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
