import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gigpoint/model/products.dart';
import 'package:gigpoint/screens/shop/products/productdetails/product_details_page.dart';
import 'package:gigpoint/utils/app_utils.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/widgets/cache_image.dart';
import 'package:gigpoint/widgets/no_data_widget.dart';
import 'package:gigpoint/widgets/points_widget.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class ProductsCarousel extends StatelessWidget {
  const ProductsCarousel(
      {Key? key, required this.products, required this.addBoxShadow})
      : super(key: key);
  final List<Product> products;
  final bool addBoxShadow;

  @override
  Widget build(BuildContext context) {
    return products.isEmpty
        ? const NoDataWidget(msg: 'No Products to Display')
        : CarouselSlider(
            options: CarouselOptions(
              autoPlay: false,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 400),
              autoPlayCurve: Curves.fastOutSlowIn,
              pauseAutoPlayOnTouch: true,
              height: 130,
              onPageChanged: (index, reason) {},
            ),
            items: products.map((product) {
              return Builder(builder: (BuildContext context) {
                return _buildPage(context, product);
              });
            }).toList(),
          );
  }

  _buildPage(BuildContext context, Product product) {
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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
              boxShadow: addBoxShadow
                  ? const [
                      BoxShadow(
                        color: Color.fromRGBO(89, 88, 88, 0.12),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: Offset(0, 1),
                      ),
                    ]
                  : null,
              borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                children: [
                  SizedBox(
                    height: 110,
                    width: 80,
                    child: Center(
                      child: CacheImage(
                        imageUrl: product.primaryImageHref,
                        placeholderSize: 50,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          product.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Styles.bold(fontSize: 16),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.only(top: 5, bottom: 10),
                        //   child: Text(
                        //     product.brief ?? '',
                        //     maxLines: 2,
                        //     overflow: TextOverflow.ellipsis,
                        //     style: Styles.regular(fontSize: 12),
                        //   ),
                        // ),
                        const SizedBox(height: 12),
                        PointsWidget(
                          text: 'FOR',
                          points: product.finalCost ?? 0,
                          fontSize: 14,
                          iconSize: 16,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
