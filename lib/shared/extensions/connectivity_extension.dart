import 'package:connectivity_plus/connectivity_plus.dart';

extension ConnectivityExtension on Connectivity {
  static Connectivity connectivity = Connectivity();
  Future<bool> isConnected() async => await checkConnectivity() != ConnectivityResult.none;
}
