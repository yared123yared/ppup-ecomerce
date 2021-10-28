import 'package:flutter/material.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/constants.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/widgets/svg_image.dart';

class PointsWidget extends StatelessWidget {
  const PointsWidget({
    Key? key,
    this.text,
    required this.points,
    required this.fontSize,
    required this.iconSize,
    this.textSize,
    this.pointsColor = AppTheme.primaryColor,
  }) : super(key: key);

  final String? text;
  final double points;
  final double fontSize;
  final double? textSize;
  final double iconSize;
  final Color pointsColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (text != null)
          Text(
            text!,
            style: Styles.semiBold(fontSize: textSize ?? fontSize),
          ),
        Padding(
          padding: EdgeInsets.only(
              left: (text == null || text!.isEmpty) ? 0 : 5, right: 3, top: 2),
          child: SvgImage(
            asset: Images.coin,
            width: iconSize,
            height: iconSize,
          ),
        ),
        Text(
          '${points.toInt()}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Styles.bold(
            fontSize: fontSize,
            color: pointsColor,
          ),
        ),
      ],
    );
  }
}
