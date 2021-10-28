import 'package:flutter/material.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/constants.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/widgets/svg_image.dart';

class CategoryWiseEarnings extends StatefulWidget {
  const CategoryWiseEarnings({Key? key}) : super(key: key);

  @override
  _CategoryWiseEarningsState createState() => _CategoryWiseEarningsState();
}

class _CategoryWiseEarningsState extends State<CategoryWiseEarnings> {
  bool isShowMore = true;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Category wise Earning',
              style: Styles.bold(fontSize: 18),
            ),
            const SizedBox(height: 25),
            ListView.separated(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemBuilder: (context, index) => renderIndicator(
                titles[index],
                percentages[index],
                balances[index],
              ),
              separatorBuilder: (context, index) => const SizedBox(height: 20),
              itemCount: isShowMore ? 4 : titles.length,
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () {
                    setState(() {
                      isShowMore = !isShowMore;
                    });
                  },
                  child: Text(
                    isShowMore ? 'See More' : 'See Fewer',
                    style: Styles.semiBold(
                      fontSize: 14,
                      color: AppTheme.primaryColor,
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }

  Widget renderIndicator(String title, int percentage, String balance) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Styles.regular(fontSize: 12),
        ),
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                children: [
                  Container(
                    height: 12,
                    width: percentage.toDouble(),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '$percentage%',
                    style: Styles.bold(fontSize: 12),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SvgImage(
                    asset: Images.coin,
                    width: 14,
                    height: 14,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    balance,
                    style: Styles.bold(fontSize: 14),
                  ),
                  const Icon(
                    Icons.navigate_next,
                    color: AppTheme.primaryColor,
                  ),
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}

final List<String> titles = [
  'Normal Deliveries',
  '5-Consecutive Deliveries',
  'Express Deliveries',
  'Holiday Deliveries',
  'Normal Deliveries',
  '5-Consecutive Deliveries',
  'Express Deliveries',
  'Holiday Deliveries',
];

final List<int> percentages = [
  60,
  20,
  10,
  5,
  60,
  20,
  10,
  5,
];
final List<String> balances = [
  '3,300',
  '1,400',
  '560',
  '280',
  '3,300',
  '1,400',
  '560',
  '280'
];
