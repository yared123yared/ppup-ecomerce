import 'package:flutter/material.dart';
import 'package:gigpoint/model/categories.dart';
import 'package:gigpoint/screens/shop/products/products_list_page.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/widgets/points_widget.dart';
import 'package:gigpoint/widgets/svg_image.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class EnjoyCard extends StatelessWidget {
  const EnjoyCard({Key? key, required this.category}) : super(key: key);
  final Category category;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pushNewScreen(
          context,
          screen: ProductsListPage(
            title: category.title,
            sortBy: 'popularity',
            category: category.name,
            fromViewAll: false,
            id: '0',
            sortOrder: 'desc',
            subCategories: const [],
          ),
          withNavBar: true,
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        );
      },
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
            child: Row(
              children: [
                SvgImage(
                  asset: category.mainImageHash ?? '',
                  height: 120,
                  width: 120,
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Buy ' + category.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Styles.bold(fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        category.notes ?? '',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Styles.semiBold(
                            fontSize: 14, color: AppTheme.textSecondaryColor),
                      ),
                      const SizedBox(height: 20),
                      const PointsWidget(
                          text: 'Starts from',
                          textSize: 12,
                          points: 100,
                          fontSize: 20,
                          iconSize: 20)
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
