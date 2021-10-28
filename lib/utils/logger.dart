import 'package:injectable/injectable.dart';

@lazySingleton
class DevelopmentLogger {
  void log({required String title, String? msg, Object? object}) {
    assert(() {
      final text = 'Title: $title => Message: $msg => Object: $object';
      final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
      // ignore: avoid_print
      pattern.allMatches(text).forEach((match) => print(match.group(0)));
      return true;
    }());
  }
}
