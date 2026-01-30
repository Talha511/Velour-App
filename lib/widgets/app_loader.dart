import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velour/utils/appcolors.dart';
import 'dart:math' as math;

class AppLoader extends StatelessWidget {
  final String? message;
  const AppLoader({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const ProfessionalLoaderWidget(),
          if (message != null) ...[
            SizedBox(height: 20.h),
            Text(
              message!,
              style: TextStyle(
                color: AppColors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class SimpleGradientLoader extends StatelessWidget {
  const SimpleGradientLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: ProfessionalLoaderWidget(size: 50),
    );
  }
}

class DotsLoader extends StatefulWidget {
  const DotsLoader({super.key});

  @override
  State<DotsLoader> createState() => _DotsLoaderState();
}

class _DotsLoaderState extends State<DotsLoader> with TickerProviderStateMixin {
  late List<AnimationController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(3, (index) {
      return AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 600),
      )..repeat(reverse: true);
    });

    // Stagger the animations
    for (int i = 0; i < _controllers.length; i++) {
      Future.delayed(Duration(milliseconds: i * 200), () {
        if (mounted) _controllers[i].forward();
      });
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors();

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(3, (index) {
          return AnimatedBuilder(
            animation: _controllers[index],
            builder: (context, child) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 5.w),
                width: 12.w,
                height: 12.w,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [colors.gradientStart, colors.gradientEnd],
                  ),
                  shape: BoxShape.circle,
                ),
                transform: Matrix4.translationValues(
                  0,
                  -20 * _controllers[index].value,
                  0,
                ),
              );
            },
          );
        }),
      ),
    );
  }
}

class SpinningGradientLoader extends StatefulWidget {
  const SpinningGradientLoader({super.key});

  @override
  State<SpinningGradientLoader> createState() => _SpinningGradientLoaderState();
}

class _SpinningGradientLoaderState extends State<SpinningGradientLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors();

    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.rotate(
            angle: _controller.value * 2 * 3.14159,
            child: Container(
              width: 60.w,
              height: 60.w,
              decoration: BoxDecoration(
                gradient: SweepGradient(
                  colors: [
                    colors.gradientStart,
                    colors.gradientEnd,
                    colors.gradientStart,
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
                shape: BoxShape.circle,
              ),
              child: Container(
                margin: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: colors.backgroundColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Professional Loader Widget - Main Loader for the entire app
class ProfessionalLoaderWidget extends StatefulWidget {
  final double? size;

  const ProfessionalLoaderWidget({
    super.key,
    this.size,
  });

  @override
  State<ProfessionalLoaderWidget> createState() => _ProfessionalLoaderWidgetState();
}

class _ProfessionalLoaderWidgetState extends State<ProfessionalLoaderWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors();
    final loaderSize = widget.size ?? 80.0;
    final innerSize = loaderSize * 0.8125;
    final dotSize = loaderSize * 0.25;

    return SizedBox(
      width: loaderSize,
      height: loaderSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer rotating ring
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.rotate(
                angle: _controller.value * 2 * math.pi,
                child: Container(
                  width: loaderSize,
                  height: loaderSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: SweepGradient(
                      colors: [
                        colors.gradientStart,
                        colors.gradientEnd,
                        colors.gradientStart.withValues(alpha: 0.3),
                        Colors.transparent,
                      ],
                      stops: const [0.0, 0.4, 0.7, 1.0],
                    ),
                  ),
                ),
              );
            },
          ),

          // Inner circle (background)
          Container(
            width: innerSize,
            height: innerSize,
            decoration: BoxDecoration(
              color: colors.backgroundColor.withValues(alpha: 0.5),
              shape: BoxShape.circle,
            ),
          ),

          // Pulsing center dot
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              final scale = 0.6 + (math.sin(_controller.value * 2 * math.pi) * 0.2);
              return Transform.scale(
                scale: scale,
                child: Container(
                  width: dotSize,
                  height: dotSize,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [colors.gradientStart, colors.gradientEnd],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: colors.gradientEnd.withValues(alpha: 0.5),
                        blurRadius: 15,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// Alternative: Minimal Circular Loader
class MinimalLoader extends StatefulWidget {
  final double? size;

  const MinimalLoader({
    super.key,
    this.size,
  });

  @override
  State<MinimalLoader> createState() => _MinimalLoaderState();
}

class _MinimalLoaderState extends State<MinimalLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors();
    final size = widget.size ?? 50.0;

    return SizedBox(
      width: size,
      height: size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: _MinimalLoaderPainter(
              progress: _controller.value,
              gradientStart: colors.gradientStart,
              gradientEnd: colors.gradientEnd,
            ),
          );
        },
      ),
    );
  }
}

class _MinimalLoaderPainter extends CustomPainter {
  final double progress;
  final Color gradientStart;
  final Color gradientEnd;

  _MinimalLoaderPainter({
    required this.progress,
    required this.gradientStart,
    required this.gradientEnd,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final gradient = SweepGradient(
      colors: [gradientStart, gradientEnd, gradientStart.withValues(alpha: 0.3)],
      stops: const [0.0, 0.5, 1.0],
      transform: GradientRotation(progress * 2 * math.pi),
    );

    paint.shader = gradient.createShader(rect);

    canvas.drawArc(
      rect,
      0,
      2 * math.pi * 0.75,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}