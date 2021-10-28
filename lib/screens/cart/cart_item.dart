import 'package:flutter/material.dart';
import 'package:gigpoint/model/product_details.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/widgets/cache_image.dart';
import 'package:gigpoint/widgets/counter_widget.dart';
import 'package:gigpoint/widgets/points_widget.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    Key? key,
    required this.variant,
    required this.onAddTap,
    required this.onRemoveTap,
    required this.content,
    required this.qty,
    required this.onSubTap,
  }) : super(key: key);
  final ProductSkus variant;
  final GestureTapCallback onAddTap, onSubTap, onRemoveTap;
  final String content;
  final int qty;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                CacheImage(
                  imageUrl: variant.imageHash,
                  height: 100,
                  width: 110,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        variant.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Styles.bold(fontSize: 16),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        content,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Styles.regular(fontSize: 12),
                      ),
                      const SizedBox(height: 16),
                      PointsWidget(
                        text: 'FOR',
                        textSize: 13,
                        points: variant.finalCost,
                        fontSize: 14,
                        iconSize: 15,
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CounterWidget(
                  quantity: qty,
                  onAddTap: onAddTap,
                  onRemoveTap: onSubTap,
                ),
                TextButton(
                    onPressed: onRemoveTap,
                    child: Text(
                      'Remove',
                      style: Styles.semiBold(
                          fontSize: 14, color: AppTheme.textSecondaryColor),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
