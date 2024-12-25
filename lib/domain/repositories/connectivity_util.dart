import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:todo/core/di/di.dart';

mixin ConnectivityUtil {
  final Connectivity connectivity = getIt<Connectivity>();

  @nonVirtual
  Future<bool> isConnected() async {
    final connectivityResult = await connectivity.checkConnectivity();

    if (connectivityResult.first == ConnectivityResult.mobile ||
        connectivityResult.first == ConnectivityResult.wifi) {
      return true;
    }

    return false;
  }
}
