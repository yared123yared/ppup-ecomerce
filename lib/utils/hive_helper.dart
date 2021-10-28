import 'package:gigpoint/model/home_reward_points.dart';
import 'package:gigpoint/model/login.dart';
import 'package:gigpoint/model/product_details.dart';
import 'package:gigpoint/model/products.dart';
import 'package:gigpoint/services/injection.dart';
import 'package:gigpoint/webservices/graphql_api_client.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class HiveHelper {
  static late Box<Product> cartBox;
  static late Box<LoginClass> loginBox;
  static late Box<RewardsSummary> rewardSummaryBox;
  static late Box<String> exchangeTokenBox;
  static late Box<bool> notification;
  static bool isInitialized = false;
  static initialize() async {
    try {
      await Hive.initFlutter();
      await registerAdapters();
      await openHiveBoxes();
      isInitialized = true;
    } catch (e) {
      await Hive.deleteBoxFromDisk(HiveConstants.login);
      await Hive.close();
      if (!isInitialized) {
        await registerAdapters();
        await Hive.initFlutter();
        isInitialized = true;
      }
    }
  }

  static registerAdapters() async {
    Hive.registerAdapter<Product>(ProductAdapter());
    Hive.registerAdapter<ProductSkus>(ProductSkusAdapter());
    Hive.registerAdapter<ProductParameter>(ProductParameterAdapter());
    Hive.registerAdapter<ParameterOption>(ParameterOptionAdapter());
    Hive.registerAdapter<Option>(OptionAdapter());
    Hive.registerAdapter<LoginClass>(LoginClassAdapter());
    Hive.registerAdapter<RewardsSummary>(RewardsSummaryAdapter());
    Hive.registerAdapter<PointsTransaction>(PointsTransactionAdapter());
  }

  static openHiveBoxes() async {
    cartBox = await Hive.openBox<Product>(HiveConstants.cart);
    loginBox = await Hive.openBox<LoginClass>(HiveConstants.login);
    rewardSummaryBox =
        await Hive.openBox<RewardsSummary>(HiveConstants.rewardSummary);
    exchangeTokenBox = await Hive.openBox<String>(HiveConstants.exchangeToken);
    notification = await Hive.openBox<bool>('myBox');
  }

  static getBox() {}

  static clearUserSession() async {
    getIt<GraphQLApiClient>().client.value.cache.store.reset();
    await loginBox.deleteAll(loginBox.keys);
    await rewardSummaryBox.delete('weekly');
    await rewardSummaryBox.delete('monthly');
    await cartBox.deleteAll(cartBox.keys);
  }

  void deleteFromDisk() {}
}

class HiveConstants {
  static const String login = 'login';
  static const String rewardSummary = 'reward-summary';
  static const String cart = 'cart';
  static const String exchangeToken = 'exchange-token';
}
