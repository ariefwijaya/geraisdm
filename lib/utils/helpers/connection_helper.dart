import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:geraisdm/core/app_setting.dart';

abstract class ConnectionHelper {
  ConnectionHelper._();
  static Future<bool> isNetworkOnline() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    } else {
      try {
        final result =
            await InternetAddress.lookup(AppSetting.serverHostLookup);
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          return true;
        }
      } on SocketException catch (_) {
        return false;
      }
    }

    return false;
  }
}
