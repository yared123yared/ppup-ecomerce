import 'package:flutter/material.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/styles.dart';

class BulletPointsWidget extends StatelessWidget {
  const BulletPointsWidget(
      {Key? key, required this.points, this.isScondaryColor = false})
      : super(key: key);
  final List<String> points;
  final bool isScondaryColor;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(height: 5),
      itemCount: points.length,
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.only(left: 5.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Container(
                height: 6,
                width: 6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isScondaryColor
                      ? AppTheme.textSecondaryColor
                      : Colors.black,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
                child: Text(
              points[index],
              style: isScondaryColor
                  ? Styles.semiBold(
                      fontSize: 12, color: AppTheme.textSecondaryColor)
                  : Styles.regular(fontSize: 12),
            )),
          ],
        ),
      ),
    );
  }
}
