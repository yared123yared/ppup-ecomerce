import 'package:flutter/material.dart';
import 'package:gigpoint/model/products.dart';
import 'package:gigpoint/utils/app_utils.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/widgets/cache_image.dart';
import 'package:gigpoint/widgets/points_widget.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'productdetails/product_details_page.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppUtils.removeFocus();
        pushNewScreen(
          context,
          screen: ProductDetailsPage(productId: product.id),
          withNavBar: true,
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 90,
                width: 80,
                child: Center(
                  child: CacheImage(
                    imageUrl: product.primaryImageHref,
                    placeholderSize: 50,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                product.title,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Styles.bold(fontSize: 14),
              ),
              const Spacer(),
              // Padding(
              //   padding: const EdgeInsets.only(top: 4, bottom: 10),
              //   child: Text(
              //     product.brief ?? '',
              //     textAlign: TextAlign.center,
              //     maxLines: 2,
              //     overflow: TextOverflow.ellipsis,
              //     style: Styles.regular(fontSize: 12),
              //   ),
              // ),
              PointsWidget(
                text: 'FOR',
                points: product.finalCost ?? 0,
                fontSize: 14,
                iconSize: 15,
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
