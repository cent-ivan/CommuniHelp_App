import 'package:communihelp_app/ViewModel/Connection_Controller/Controller/snackbars.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  //Snackbars
  SnackBars snackBars = SnackBars();

  RxBool isOnline = true.obs; //use this to check if its online

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(List<ConnectivityResult> connectivityResult) {
    isOnline.value = !connectivityResult.contains(ConnectivityResult.none);

    if (connectivityResult.contains(ConnectivityResult.none)) {
      snackBars.noConnection();
    }
    else {
      snackBars.closeSnackBar();
    }
  }
}