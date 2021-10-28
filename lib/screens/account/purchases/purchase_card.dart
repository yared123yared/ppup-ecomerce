import 'package:flutter/material.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/constants.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/widgets/cache_image.dart';

// ignore: must_be_immutable
class PurchaseCard extends StatelessWidget {
  const PurchaseCard({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // pushNewScreen(
        //   context,
        //   screen: PurchaseDetailsPage(orderStatus: index),
        //   withNavBar: true,
        //   pageTransitionAnimation: PageTransitionAnimation.cupertino,
        // );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Row(
            children: [
              const CacheImage(
                imageUrl: Constants.dummyImgUrl,
                height: 80,
                width: 80,
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'JBL Tune 120TWS JBL Tune 120TWS JBL Tune 120TWS',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Styles.semiBold(fontSize: 16),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        'No wires. No hassles. Introducing the completely cord free',
                        style: Styles.regular(fontSize: 12),
                      ),
                    ),
                    Text(
                      index == 0
                          ? 'Delivery by June 28'
                          : index == 1
                              ? 'Cancelled on 10th May 2021'
                              : index == 2
                                  ? 'Returned on 10th May 2021'
                                  : index == 3
                                      ? 'Delivered on 10th May 2021'
                                      : '',
                      style: Styles.semiBold(
                          fontSize: 12,
                          color: (index == 0)
                              ? AppTheme.primaryColor
                              : AppTheme.textPrimaryColor),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
