import 'package:gigpoint/utils/constants.dart';

class Slide {
  final String title, desc, image;

  Slide({required this.title, required this.desc, required this.image});
}

final List<Slide> sliderList = [
  //Slide(
  //title: 'GigPoint',
  //desc:
  // '<b style="font-weight: 600; font-size:18px; color:black">A community for Gig Workers</b>',
  // image: Images.onboarding_1,
  //),
  Slide(
    title: 'GigPoint',
    desc: 'A community for Gig Workers',
    image: Images.onboarding_1,
  ),
  Slide(
    title: 'Earn Redeemable Work Points',
    desc: 'Earn redeemable points for sucessfully completed orders and more….',
    image: Images.onboarding_2,
  ),
  // Slide(
  //   title: 'Collect Point Pickup Badges',
  //   desc:
  //       'From being consistently on-time to referring a friend, <b style="font-weight: 700">Earn a Badge</b> for every <b style="font-weight: 700">Achievement!</b>',
  //   image: Images.onboarding_3,
  // ),
  //Slide(
  //title: 'Purchase Rewards with Points',
  //desc:
  //  'Exchange your reward points for attractive prizes like <b style="font-weight: 700">Electronics, Home Appliances</b> and <b style="font-weight: 700">Entertainment</b>',
  //image: Images.onboarding_4,
  //),
  Slide(
    title: 'Shop Rewards with Points',
    desc:
        'Exchange your reward points for useful prizes such as Electronics, Home Appliances and Entertainment',
    image: Images.onboarding_4,
  ),
  //Slide(
  //title: 'Get Access to Financial and Insurance Benefits',
  //desc:
  //'Open a <b style="font-weight: 700">Digital Bank Account</b> and purchase affordable <b style="font-weight: 700">Insurance Packages</b> with GigPoint.',
  //image: Images.onboarding_5,
  //),
  Slide(
    title: 'Access Helpful Financial and Insurance Benefits',
    desc:
        'Open a Digital Bank Account and purchase affordable Insurance Packages with GigPoint',
    image: Images.onboarding_5,
  ),
];
