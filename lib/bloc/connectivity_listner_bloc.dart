import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

@lazySingleton
class ConnectivityListnerBloc {
  var subject = BehaviorSubject.seeded(true);
  Stream<bool> get responseData => subject.stream;

  Future<bool> getNetworkStatus() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      subject.sink.add(false);
      return false;
    } else {
      subject.sink.add(true);
      return true;
    }
  }

  Future<bool> refresh() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      subject.sink.add(false);
      return false;
    } else {
      subject.sink.add(true);
      return true;
    }
  }

  updateNetworkStatus(bool status) => subject.sink.add(status);

  @disposeMethod
  dispose() async {
    await subject.drain();
    // _connectivitySubscription.cancel();
    subject.close();
  }
}
