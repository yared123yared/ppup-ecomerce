// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:yaml/yaml.dart';

class Env {
  static String API_BASE_URL = '';
  static String API_KEY = '';
  static String BANKING_URL = '';
  static String INSURANCE_URL = '';
  static String FORGOT_PASSWORD_URL = '';
  static String TERMS_AND_CONDITIONS = '';
  static String PRIVACY_POLICY = '';

  static String BUILD_NUMBER = '';
  static String BUILD_VERSION = '';

  static Future<bool> loadConfigFile() async {
    try {
      String yamlString = await rootBundle.loadString('configuration.yaml');
      final dynamic configMap = loadYaml(yamlString);

      API_BASE_URL = configMap['api_base_url'];
      API_KEY = configMap['api_key'];
      BANKING_URL = configMap['banking_url'];
      INSURANCE_URL = configMap['insurance_url'];
      FORGOT_PASSWORD_URL = configMap['forgot_password_url'];
      TERMS_AND_CONDITIONS = configMap['terms_and_conditions'];
      PRIVACY_POLICY = configMap['privacy_policy'];
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
