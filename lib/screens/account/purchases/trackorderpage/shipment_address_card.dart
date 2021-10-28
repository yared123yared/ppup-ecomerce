import 'package:flutter/material.dart';
import 'package:gigpoint/utils/styles.dart';

class ShipmentAddressCard extends StatelessWidget {
  const ShipmentAddressCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Shipment Address',
              style: Styles.bold(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Text(
              'Tim Koorbusch',
              style: Styles.semiBold(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              '4603 White Oak Drive, Kansas City, Missouri,United States-64108816+1-726-5981',
              style: Styles.regular(fontSize: 14),
            )
          ],
        ),
      ),
    );
  }
}
