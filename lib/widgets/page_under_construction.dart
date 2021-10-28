import 'package:flutter/material.dart';
import 'package:gigpoint/utils/constants.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/widgets/svg_image.dart';

class PageUnderConstruction extends StatelessWidget {
  const PageUnderConstruction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SvgImage(asset: Images.underConstruction, height: 150),
          const SizedBox(height: 30),
          Text(
            'This Page is Under Construction',
            textAlign: TextAlign.center,
            style: Styles.bold(fontSize: 20),
          ),
          const SizedBox(height: 14),
          Text(
            'We are working on it.',
            style: Styles.regular(fontSize: 16),
          )
        ],
      ),
    );
  }
}
