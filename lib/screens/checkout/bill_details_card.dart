import 'package:flutter/material.dart';
import 'package:gigpoint/model/product_details.dart';
import 'package:gigpoint/model/products.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/constants.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/widgets/points_widget.dart';
import 'package:gigpoint/widgets/svg_image.dart';

class BillDetailsCard extends StatelessWidget {
  const BillDetailsCard({
    Key? key,
    required this.products,
    this.cartValue,
    required this.avaliablePoints,
    required this.balancePoints,
  }) : super(key: key);
  final List<Product> products;
  final double? cartValue;
  final double avaliablePoints;
  final double balancePoints;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'BILL DETAILS',
              style: Styles.bold(fontSize: 16),
            ),
            const SizedBox(height: 10),
            rowWidget('Available GigPoints', avaliablePoints),
            const SizedBox(height: 10),
            cartValue != null
                ? rowWidget('Cart Value', cartValue ?? 0, '-')
                : ListView.separated(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemBuilder: (context, index) {
                      ProductSkus varient = products[index].selectedVariant!;
                      return rowWidget(
                        varient.title,
                        varient.finalCost * products[index].qty,
                        '-',
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 8),
                    itemCount: products.length,
                  ),
            const SizedBox(height: 18),
            const Divider(thickness: 1.2, height: 0),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Balance after deduction',
                  style: Styles.semiBold(fontSize: 16),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (balancePoints < 0)
                      Text(
                        '-',
                        style: Styles.bold(
                          fontSize: 18,
                          color: const Color.fromRGBO(253, 103, 94, 1),
                        ),
                      ),
                    const Padding(
                      padding: EdgeInsets.only(left: 5, right: 3),
                      child: SvgImage(
                        asset: Images.coin,
                        width: 18,
                        height: 18,
                      ),
                    ),
                    Text(
                      '${balancePoints.toInt().abs()}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Styles.bold(
                        fontSize: 18,
                        color: balancePoints > 0
                            ? AppTheme.textPrimaryColor
                            : const Color.fromRGBO(253, 103, 94, 1),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget rowWidget(String title, double points, [String? prefix]) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Styles.semiBold(
                fontSize: 14, color: AppTheme.textSecondaryColor),
          ),
        ),
        const SizedBox(width: 12),
        PointsWidget(
          text: prefix ?? '',
          points: points,
          fontSize: 14,
          iconSize: 14,
          pointsColor: AppTheme.textPrimaryColor,
        )
      ],
    );
  }
}
