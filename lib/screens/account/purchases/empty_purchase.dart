import 'package:flutter/material.dart';
import 'package:gigpoint/utils/constants.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/widgets/svg_image.dart';

class EmptyPurchasesPage extends StatelessWidget {
  const EmptyPurchasesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 70),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SvgImage(
              asset: Images.emptyPurchases,
              width: 180,
              height: 180,
            ),
            const SizedBox(height: 20),
            Text(
              'No Purchase History',
              style: Styles.bold(fontSize: 20),
            ),
            const SizedBox(height: 15),
            Text(
              'Looks like you haven\'t made your choice yet!',
              textAlign: TextAlign.center,
              style: Styles.regular(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
