// ignore_for_file: constant_identifier_names

class Constants {
  ///Image assets path.
  static const String imagePath = 'assets/images/';

  ///Define Font Family
  static const String fontFamily = 'OpenSans';
  static const String dummyImgUrl =
      'https://imaginestore.org/wp-content/uploads/2020/09/watch6-700x615.png';

  ///Default value is 364.0
  static const double dialogWidth = 364.0;
  static const String driverAppPlayStoreUrl = 'http://lkksm.app.link/';
  static const String driverAppAppStoreUrl = 'http://lkksm.app.link/';

  static const List<String> countries = ['United States'];

  static const List<String> addressTypes = [
    'Home 7am-9am Delivery',
    'Office 9am - 5am Delivery',
  ];

  static const String primary = 'primary';
  static const double MIN_PRICE_RANGE = 0;
  static const double MAX_PRICE_RANGE = 25000;
  static const double DEFAULT_PAGINATION_COUNT = 10;
}

class Images {
  static const String logo = Constants.imagePath + 'logo.svg';
  static const String logoWithText = Constants.imagePath + 'logo_text.svg';
  static const String onboarding_1 = Constants.imagePath + 'onboarding_1.svg';
  static const String onboarding_2 = Constants.imagePath + 'onboarding_2.svg';
  static const String onboarding_3 = Constants.imagePath + 'onboarding_3.svg';
  static const String onboarding_4 = Constants.imagePath + 'onboarding_4.svg';
  static const String onboarding_5 = Constants.imagePath + 'onboarding_5.svg';
  static const String success = Constants.imagePath + 'success.svg';
  static const String iconMsg = Constants.imagePath + 'iconmsg.svg';
  static const String manage = Constants.imagePath + 'manage.svg';
  static const String earn = Constants.imagePath + 'earn.svg';
  static const String enjoy = Constants.imagePath + 'enjoy.svg';
  static const String recreation = Constants.imagePath + 'recreation.svg';
  static const String personal = Constants.imagePath + 'personal.svg';
  static const String housewares = Constants.imagePath + 'housewares.svg';
  static const String electronics = Constants.imagePath + 'electronics.svg';
  static const String filter = Constants.imagePath + 'filter.svg';
  static const String coin = Constants.imagePath + 'coin.svg';
  static const String firstTimeBonus = Constants.imagePath + 'bonus.svg';
  static const String onTime = Constants.imagePath + 'on_time.svg';
  static const String holiday = Constants.imagePath + 'holiday.svg';
  static const String normal = Constants.imagePath + 'normal.svg';
  static const String onTimeArrival =
      Constants.imagePath + 'on_time_arrival.svg';
  static const String peakHour = Constants.imagePath + 'peak_hour.svg';
  static const String weekend = Constants.imagePath + 'weekend.svg';
  static const String purhaseElectronics =
      Constants.imagePath + 'purchase_electronics.svg';
  static const String purhasePersonal =
      Constants.imagePath + 'purchase_personal.svg';
  static const String purhaseHouseware =
      Constants.imagePath + 'purchase_houseware.svg';
  static const String purhaseRecreation =
      Constants.imagePath + 'purchase_recreation.svg';
  static const String purhaseMusic = Constants.imagePath + 'purchase_music.svg';
  static const String purhaseeCertificates =
      Constants.imagePath + 'purchase_ecertificates.svg';
  static const String emptyCart = Constants.imagePath + 'empty_cart.svg';
  static const String check = Constants.imagePath + 'check.svg';
  static const String emptyPurchases =
      Constants.imagePath + 'empty_purchases.svg';
  static const String emptyNotification =
      Constants.imagePath + 'empty_notification.svg';
  static const String underConstruction =
      Constants.imagePath + 'under_construction.svg';
  static const String noProductsForCurrentPoints =
      Constants.imagePath + 'no_products.svg';
  static const String goSearchProduct = Constants.imagePath + 'go_search.svg';
  static const String callIcon = Constants.imagePath + 'callIcon.svg';
  static const String pointInsuranceplan =
      Constants.imagePath + 'point_insurance_plan.svg';
  static const String pointTrustBank =
      Constants.imagePath + 'point_trust_bank_account.svg';
  static const String inputNext = Constants.imagePath + 'inputNext.svg';
  static const String music = Constants.imagePath + 'music.svg';
  static const String noInternet = Constants.imagePath + 'no_internet.svg';
}

class LottieAnims {
  static const String splashIcon = Constants.imagePath + 'splash.json';
}

class Routes {
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String dashboard = '/dashboard';
  static const String termsAndConditions = '/terms-conditions';
}
