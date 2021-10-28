import 'package:flutter/material.dart';
import 'package:gigpoint/utils/styles.dart';

import 'faq_activity.dart';
import 'faq_list.dart';

class RewardsAndShopFAQTab extends StatefulWidget {
  const RewardsAndShopFAQTab({Key? key}) : super(key: key);

  @override
  _RewardsAndShopFAQTabState createState() => _RewardsAndShopFAQTabState();
}

class _RewardsAndShopFAQTabState extends State<RewardsAndShopFAQTab> {
  /// FAQ List
  List<FAQList> rewardsAndShopFaqList = [];

  @override
  void initState() {
    super.initState();
    getLoadRewardAndShopFAQList();
  }

  getLoadRewardAndShopFAQList() {
    setState(() {
      rewardsAndShopFaqList.add(FAQList(
        title: 'What is the GigPoint Program?',
        description:
            'GigPoint is an incentive program designed for Gig Workers to encourage activities and behaviors that lead to a successful career as a Gig Worker.',
      ));
      rewardsAndShopFaqList.add(FAQList(
        title: 'What is GigPoint?',
        description:
            'GigPoint is a rewards and loyalty program for Point Pickup workers that offers redeemable rewards and financial and  insurance benefits.',
      ));
      rewardsAndShopFaqList.add(FAQList(
        title: 'Who can participate?',
        description:
            'Point Pickup workers are eligible to participate in GigPoint.',
      ));
      rewardsAndShopFaqList.add(FAQList(
        title: 'How do I enroll? ',
        description:
            'Log into GigPoint using your Point Pickup email and password.',
      ));
      rewardsAndShopFaqList.add(FAQList(
        title: 'What are Rewards Points?',
        description:
            'Reward points are points you receive for successfully completing orders as outlined under ‘Earn’ in your homepage.',
      ));
      rewardsAndShopFaqList.add(FAQList(
        title: 'What can I redeem my Rewards Points for?',
        description:
            'Rewards points can be redeemed for merchandise, retailer eGift cards, or Prepaid Mastercard® Virtual Card.',
      ));
      rewardsAndShopFaqList.add(FAQList(
        title: 'How do I redeem my Points?',
        description:
            'Simply shop for items through the app, add to your cart, and check out.',
      ));
      rewardsAndShopFaqList.add(FAQList(
        title:
            'Do the Rewards Points I use for my redemptions include tax and shipping?',
        description:
            'All shipping and handling charges are included in your rewards. Any liability for federal, state or local income taxes for rewards from this program will be the sole responsibility of the participant receiving the reward. Participation in the GigPoint Program may result in the receipt of taxable income from Point Pickup.',
      ));
      rewardsAndShopFaqList.add(FAQList(
        title: 'Is there a limit on how many Rewards Points I can earn?',
        description: 'There is no limit to the number of points you can earn.',
      ));
      rewardsAndShopFaqList.add(FAQList(
        title: 'How are points accumulated?',
        description:
            'Points are earned with every successfully completed order on the Point Pickup Driver App.',
      ));
      rewardsAndShopFaqList.add(FAQList(
        title: 'When does my Rewards Points Balance get updated?',
        description:
            'Your point balance statement will be updated 24 hours after every successful order.',
      ));
      rewardsAndShopFaqList.add(FAQList(
        title: 'Where can I view my Rewards Points?',
        description: 'You can view your points under GigPoints Summary.',
      ));
      rewardsAndShopFaqList.add(FAQList(
        title: 'Do the Rewards Points ever expire?',
        description:
            'Points will expire if you have not accessed the GigPoint mobile application for a period of 6 months.',
      ));
      rewardsAndShopFaqList.add(FAQList(
        title: 'Can I purchase additional Rewards Points?',
        description: 'No, additional points cannot be purchased.',
      ));
      rewardsAndShopFaqList.add(FAQList(
        title: 'Where can I view the Order/Shipping status of my orders?',
        description:
            'You can view the status of your order or your transaction history under My Purchases in the menu.',
      ));
      rewardsAndShopFaqList.add(FAQList(
        title: 'How long will it take for my orders to arrive?',
        description:
            'While we cannot guarantee delivery dates, merchandise rewards typically ship between 10-12 business days. e-Gift or Prepaid Mastercard® Virtual Cards will be sent to your email, typically in less than 2 hours.',
      ));
      rewardsAndShopFaqList.add(FAQList(
        title: 'Who do I contact if I have not received my order? ',
        description:
            'Contact Award Headquarters at rewards@pointpickup.com, 800-621-4112.',
      ));
      rewardsAndShopFaqList.add(FAQList(
        title: 'How do I check my prepaid Mastercard® Virtual Card Balance?',
        description:
            'Visit https://www.myprepaidcenter.com or call 1-888-371-2109.',
      ));
      rewardsAndShopFaqList.add(FAQList(
        title: 'Where can I use my prepaid Mastercard® Virtual Card?',
        description:
            'Your Rewards Card can be used everywhere MasterCard debit cards are accepted.',
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
            child: Text(
              'FAQ',
              style: Styles.bold(fontSize: 18),
            ),
          ),
          ListView.separated(
            itemCount: rewardsAndShopFaqList.length,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            shrinkWrap: true,
            primary: false,
            padding: const EdgeInsets.only(bottom: 10),
            itemBuilder: (context, index) =>
                FaqActivity(faqList: rewardsAndShopFaqList[index]),
          )
        ],
      ),
    );
  }
}
