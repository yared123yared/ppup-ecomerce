import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgImage extends StatelessWidget {
  final String asset;
  final double? width, height;
  final BoxFit boxFit;
  final Color? color;
  const SvgImage({
    Key? key,
    required this.asset,
    this.width,
    this.height,
    this.boxFit = BoxFit.contain,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      asset,
      width: width,
      height: height,
      fit: boxFit,
      color: color,
      matchTextDirection: true,
    );
  }
}
