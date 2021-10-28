import 'package:flutter/material.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/widgets/bullet_points_widget.dart';

class ProductSpecifications extends StatelessWidget {
  const ProductSpecifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Specifications',
          style: Styles.semiBold(fontSize: 14),
        ),
        const SizedBox(height: 20),
        BulletPointsWidget(points: specifications),
      ],
    );
  }
}

final List<String> specifications = [
  'JBL Tune 120TWS Truly Wireless in-Ear Headphones',
  'JBL Pure Bass Sound',
  'Truly Wireless',
  'Hands-free Stereo Calls',
  '16 Hours of combined Playtime under optimum audio',
  'With a 15-minute quick charge for 1 hour of music playback',
  'Elegantly designed Portable Charging Case'
];
