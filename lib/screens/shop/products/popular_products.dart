import 'package:flutter/material.dart';
import 'package:gigpoint/model/products.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/app_utils.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/widgets/no_data_widget.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'products_list_page.dart';
import 'product_card.dart';

class PopularProducts extends StatelessWidget {
  const PopularProducts({Key? key, required this.products}) : super(key: key);
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Popular Products',
                style: Styles.bold(fontSize: 16),
              ),
              TextButton(
                  onPressed: () {
                    AppUtils.removeFocus();
                    pushNewScreen(
                      context,
                      screen: const ProductsListPage(
                        id: '0',
                        title: 'Popular Products',
                        sortBy: 'popularity',
                        fromViewAll: true,
                        subCategories: [],
                      ),
                      withNavBar: true,
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
                  },
                  child: Text(
                    'View All',
                    style: Styles.bold(
                      fontSize: 16,
                      color: AppTheme.primaryColor,
                    ),
                  ))
            ],
          ),
          const SizedBox(height: 5),
          products.isEmpty
              ? const NoDataWidget(msg: 'No Products to Display')
              : GridView.builder(
                  primary: false,
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(bottom: 10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    mainAxisExtent: 200,
                  ),
                  itemCount: products.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ProductCard(product: products[index]);
                  },
                )
        ],
      ),
    );
  }
}
