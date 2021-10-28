import 'package:flutter/material.dart';
import 'package:gigpoint/model/categories.dart';
import 'package:gigpoint/screens/shop/products/products_list_page.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/app_utils.dart';
import 'package:gigpoint/utils/constants.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/widgets/svg_image.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({Key? key, required this.categories})
      : super(key: key);
  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            AppUtils.removeFocus();
            pushNewScreen(
              context,
              screen: ProductsListPage(
                title: categories[index].title,
                category: categories[index].name,
                sortBy: 'popularity',
                id: '0',
                subCategories: const [],
              ),
              withNavBar: true,
              pageTransitionAnimation: PageTransitionAnimation.cupertino,
            );
          },
          child: Column(
            children: [
              Container(
                height: 80,
                width: 80,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.primaryLightColor,
                ),
                child: SvgImage(
                  asset: categoryImages[index],
                  width: 28,
                  height: 28,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 80,
                child: Text(
                  categories[index].title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: Styles.semiBold(fontSize: 12),
                ),
              )
            ],
          ),
        ),
        separatorBuilder: (context, index) => const SizedBox(width: 15),
        itemCount: categories.length,
      ),
    );
  }
}

final List<String> categoryImages = [
  Images.housewares,
  Images.personal,
  Images.recreation,
  Images.electronics,
  Images.music,
  Images.electronics,
  Images.music,
];
