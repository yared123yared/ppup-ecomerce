import 'package:flutter/material.dart';
import 'package:gigpoint/utils/constants.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/widgets/cache_image.dart';

class TrackProductCard extends StatelessWidget {
  const TrackProductCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const CacheImage(
              imageUrl: Constants.dummyImgUrl,
              height: 86,
              width: 86,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'JBL Tune 120TWS…',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Styles.semiBold(fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'No wires. No hassles. Introducing the completely cord free',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Styles.regular(fontSize: 14),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
