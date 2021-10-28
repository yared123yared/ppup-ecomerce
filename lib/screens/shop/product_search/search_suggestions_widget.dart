import 'package:flutter/material.dart';
import 'package:gigpoint/model/products.dart';
import 'package:gigpoint/screens/shop/products/productdetails/product_details_page.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/constants.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/widgets/cache_image.dart';
import 'package:gigpoint/widgets/no_data_widget.dart';
import 'package:gigpoint/widgets/svg_image.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class SearchSuggestionsWidget extends StatelessWidget {
  const SearchSuggestionsWidget(
      {Key? key, required this.products, required this.onViewAllPressed})
      : super(key: key);

  final VoidCallback onViewAllPressed;
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: products.isEmpty
              ? const Center(
                  child: NoDataWidget(
                    msg: 'No Products Found!',
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    var item = products[index];
                    return GestureDetector(
                      onTap: () {
                        pushNewScreen(
                          context,
                          screen: ProductDetailsPage(productId: item.id),
                          withNavBar: true,
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
                      },
                      child: Row(
                        children: [
                          SizedBox(
                            height: 35,
                            width: 35,
                            child: Center(
                              child: CacheImage(
                                imageUrl: item.primaryImageHref,
                                placeholderSize: 32,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              item.title,
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Styles.semiBold(fontSize: 14),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(12.0),
                            child: SvgImage(
                                asset: Images.inputNext, width: 24, height: 24),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
        if (products.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              child: Text('View All',
                  style:
                      Styles.bold(fontSize: 16, color: AppTheme.primaryColor)),
              onPressed: onViewAllPressed,
            ),
          ),
      ],
    );
  }
}
