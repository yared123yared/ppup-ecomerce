import 'package:flutter/material.dart';
import 'package:gigpoint/screens/home/earn/earn_page.dart';
import 'package:gigpoint/screens/home/enjoy/enjoy_page.dart';
import 'package:gigpoint/screens/home/rewards/rewards_summary_page.dart';
import 'package:gigpoint/utils/constants.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/widgets/svg_image.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = (MediaQuery.of(context).size.width / 3) - 20;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int i = 0; i < titles.length; i++)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: GestureDetector(
                onTap: () {
                  pushNewScreen(
                    context,
                    screen: i == 0
                        ? const EarnPage()
                        : i == 1
                            ? const RewardsSummaryPage(initialIndex: 1)
                            : const EnjoyPage(),
                    withNavBar: true, // OPTIONAL VALUE. True by default.
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
                child: Column(
                  children: [
                    Container(
                      constraints: BoxConstraints(
                        maxHeight: width,
                        maxWidth: width,
                        // maxHeight: 118,
                        // maxWidth: 118,
                      ),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(251, 251, 251, 1),
                        border: Border.all(
                          color: Colors.white,
                          width: 5,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: SvgImage(
                        asset: images[i],
                        height: 90,
                        width: 90,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      titles[i],
                      style: Styles.bold(fontSize: 14),
                    )
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}

final List<String> titles = ['EARN', 'MANAGE', 'ENJOY'];
final List<String> images = [
  Images.earn,
  Images.manage,
  Images.enjoy,
];
