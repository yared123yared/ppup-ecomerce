import 'package:flutter/material.dart';
import 'package:gigpoint/screens/home/earn/earn_page.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/widgets/points_widget.dart';
import 'package:gigpoint/widgets/svg_image.dart';

import 'more_content.dart';

class EarnActivity extends StatelessWidget {
  const EarnActivity({
    Key? key,
    this.isExpanded = false,
    required this.onPressed,
    required this.data,
  }) : super(key: key);
  final bool isExpanded;
  final VoidCallback? onPressed;
  final EarnData data;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            color: isExpanded ? AppTheme.primaryColor : Colors.white,
          )),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                SvgImage(
                  asset: data.image,
                  width: 128,
                  height: 128,
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.title,
                        style: Styles.bold(fontSize: 20),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: PointsWidget(
                          text: '',
                          points: data.points,
                          fontSize: 18,
                          iconSize: 20,
                        ),
                      ),
                      Text(
                        data.desc,
                        style: Styles.semiBold(
                            fontSize: 14, color: AppTheme.textSecondaryColor),
                      )
                    ],
                  ),
                )
              ],
            ),
            TextButton.icon(
              onPressed: onPressed,
              icon: Text(
                isExpanded ? 'Less' : 'More',
                style: Styles.bold(
                  fontSize: 14,
                  color: AppTheme.primaryColor,
                ),
              ),
              label: Icon(
                isExpanded ? Icons.expand_less : Icons.expand_more,
                color: AppTheme.primaryColor,
              ),
            ),
            if (isExpanded) MoreContent(criteria: data.criteria),
          ],
        ),
      ),
    );
  }
}
