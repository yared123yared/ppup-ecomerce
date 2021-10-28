import 'package:flutter/material.dart';
import 'package:gigpoint/utils/constants.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/widgets/svg_image.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // const SizedBox(height: 130),
            const SvgImage(
              asset: Images.emptyCart,
              width: 180,
              height: 180,
            ),
            const SizedBox(height: 34),
            Text(
              'Your Cart is Empty',
              textAlign: TextAlign.center,
              style: Styles.bold(fontSize: 20),
            ),
            const SizedBox(height: 15),
            Text(
              'Get shopping!',
              textAlign: TextAlign.center,
              style: Styles.regular(fontSize: 16),
            )
          ],
        ),
      ),
    );
  }
}
