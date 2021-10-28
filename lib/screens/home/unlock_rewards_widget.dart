import 'package:flutter/material.dart';
import 'package:gigpoint/bloc/render_widget_bloc.dart';
import 'package:gigpoint/screens/dashboard/dashboard_page.dart';
import 'package:gigpoint/services/injection.dart';
import 'package:gigpoint/utils/app_theme.dart';
import 'package:gigpoint/utils/strings.dart';
import 'package:gigpoint/utils/styles.dart';
import 'package:gigpoint/widgets/points_widget.dart';

class UnlockRewardsWidget extends StatelessWidget {
  const UnlockRewardsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(exploreBenefitsString, style: Styles.bold(fontSize: 16)),
        ),
        SizedBox(
          height: 210,
          child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(width: 12),
            itemCount: rewards.length,
            padding: const EdgeInsets.all(12),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => SizedBox(
              width: 170,
              child: GestureDetector(
                onTap: () {
                  switch (index) {
                    case 0:
                      getIt<RenderWidgetBloc>().render(1);
                      controller.jumpToTab(1);
                      break;
                    case 1:
                      getIt<RenderWidgetBloc>().render(2);
                      controller.jumpToTab(2);
                      break;
                    case 2:
                      getIt<RenderWidgetBloc>().render(2);
                      controller.jumpToTab(2);
                      break;
                    default:
                  }
                },
                child: Card(
                  margin: const EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          rewards[index].icon,
                          size: 36,
                          color: AppTheme.primaryColor,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          rewards[index].title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Styles.semiBold(fontSize: 14),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            rewards[index].subTiitle,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Styles.regular(fontSize: 12),
                          ),
                        ),
                        const Spacer(),
                        const PointsWidget(
                          text: 'EARN',
                          points: 100,
                          fontSize: 14,
                          iconSize: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

List<UnlockRewards> rewards = [
  UnlockRewards(Icons.savings_outlined, 'Open a Savings\nAccount',
      'No overdraft fees', false),
  UnlockRewards(Icons.health_and_safety_outlined, 'Health\nInsurance',
      'Competitive packages', false),
  UnlockRewards(Icons.visibility_outlined, 'Vision\nInsurance',
      'Low monthly premiums', true),
];

class UnlockRewards {
  final IconData icon;
  final String title;
  final String subTiitle;
  final bool viewMore;

  UnlockRewards(this.icon, this.title, this.subTiitle, this.viewMore);
}
