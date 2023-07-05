import 'package:fluttertoast/fluttertoast.dart';

class AlertMessages {
  showErrorToast(String msg) {
    Fluttertoast.showToast(msg: msg);
  }
}
