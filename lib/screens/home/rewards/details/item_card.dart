import 'package:flutter/material.dart';
import 'package:gigpoint/model/points.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/widgets/cache_image.dart';
import 'package:intl/intl.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({Key? key, required this.reward}) : super(key: key);

  final PointsTransaction reward;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CacheImage(
        imageUrl: '',
        height: 35,
        width: 35,
      ),
      title: Text(
        reward.description ?? '-',
        style: Styles.semiBold(fontSize: 16),
      ),
      subtitle: Text(
        DateFormat('dd MMM yyyy').format(reward.date!),
        style:
            Styles.semiBold(fontSize: 12, color: AppTheme.textSecondaryColor),
      ),
      trailing: reward.numPoints! > 0
          ? Text(
              '+${reward.numPoints?.toInt()}',
              style: Styles.semiBold(fontSize: 16, color: AppTheme.greenColor),
            )
          : Text(
              '${reward.numPoints?.toInt()}',
              style: Styles.semiBold(fontSize: 16, color: AppTheme.redColor),
            ),
    );
  }
}
