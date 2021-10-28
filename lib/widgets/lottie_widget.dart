import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieWidget extends StatelessWidget {
  final String asset;
  final double? width, height;
  final BoxFit boxFit;
  const LottieWidget({
    Key? key,
    required this.asset,
    this.width,
    this.height,
    this.boxFit = BoxFit.contain,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      asset,
      width: width,
      height: height,
      fit: boxFit,
    );
  }
}
