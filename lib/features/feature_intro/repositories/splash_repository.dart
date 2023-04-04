import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

class SplashRepository {
  Future<bool> checkConnecticity() async {
    //check internet connection without any package
    // try {
    //   final result = await InternetAddress.lookup('example.com');
    //   return result.isNotEmpty && result[0].rawAddress.isNotEmpty;

    // } on SocketException catch (_) {
    //   return false;
    // }

    //check (data/wifi) is on/off with connectivity_plus package
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
      return true;
    } else {
      return false;
    }
  }
}
