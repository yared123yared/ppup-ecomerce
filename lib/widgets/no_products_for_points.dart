import 'package:flutter/material.dart';
import 'package:gigpoint/utils/constants.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/widgets/svg_image.dart';

class NoProductsForYourPoints extends StatelessWidget {
  const NoProductsForYourPoints({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SvgImage(
              asset: Images.noProductsForCurrentPoints,
              height: 180,
              width: 180),
          const SizedBox(height: 35),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Text(
              'There are no products for your selected criteria',
              textAlign: TextAlign.center,
              style: Styles.bold(fontSize: 20),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Text(
              'Try with different combinations',
              style: Styles.regular(fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}
