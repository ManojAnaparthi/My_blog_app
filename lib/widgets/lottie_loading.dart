import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieLoading extends StatelessWidget {
  final double size;
  const LottieLoading({this.size = 120, super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'lib/assets/loading.json',
      width: size,
      height: size,
      fit: BoxFit.contain,
    );
  }
}
