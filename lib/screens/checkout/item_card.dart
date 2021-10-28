import 'package:flutter/material.dart';
import 'package:gigpoint/model/product_details.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/widgets/cache_image.dart';
import 'package:gigpoint/widgets/counter_widget.dart';
import 'package:gigpoint/widgets/points_widget.dart';

class ItemCard extends StatelessWidget {
  const ItemCard(
      {Key? key,
      required this.variant,
      required this.content,
      required this.qty})
      : super(key: key);
  final ProductSkus variant;
  final String content;
  final int qty;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          children: [
            Row(
              children: [
                CacheImage(
                  imageUrl: variant.imageHash,
                  height: 100,
                  width: 110,
                ),
                const SizedBox(width: 15),
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
                        text: 'For',
                        points: variant.finalCost,
                        fontSize: 14,
                        iconSize: 15,
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CounterWidget(
                  onAddTap: () {},
                  onRemoveTap: () {},
                  quantity: qty,
                ),
                const SizedBox(width: 24),
                Text(
                  'Delivery by June 28',
                  style: Styles.semiBold(fontSize: 16),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
