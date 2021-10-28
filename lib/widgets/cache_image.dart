import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gigpoint/utils/constants.dart';
import 'package:gigpoint/widgets/svg_image.dart';

class CacheImage extends StatelessWidget {
  final String imageUrl;
  final double? height, width;
  final BoxFit boxFit;
  final double borderWidth;
  final bool isCircle;
  final Color? color;
  final double? placeholderSize;

  const CacheImage({
    Key? key,
    required this.imageUrl,
    this.height,
    this.width,
    this.boxFit = BoxFit.contain,
    this.borderWidth = 0,
    this.isCircle = false,
    this.color,
    this.placeholderSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: borderWidth,
          ),
          shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
          image: DecorationImage(
            image: imageProvider,
            fit: boxFit,
          ),
        ),
      ),
      placeholder: (context, url) => placeholderWidget(),
      errorWidget: (context, url, error) => placeholderWidget(),
    );
  }

  Widget placeholderWidget() => SvgImage(
        asset: Images.logo,
        width: placeholderSize ?? width,
        height: placeholderSize ?? height,
        color: Colors.grey.shade300,
      );
}
