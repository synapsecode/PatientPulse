import 'package:patientpulse/main.dart';
import 'package:patientpulse/utils.dart';

T commonErrorHandler<T>(Map errObj, T rVal) {
  print('==========[ERROR OCCURED]==========');
  print(errObj.toString());
  // CustomDialogs.showDefaultAlertDialog(
  //   navigatorKey.currentState!.context,
  //   contentTitle: 'Error Occured',
  //   contentText: errObj.toString(),
  // );
  print('===================================');
  return rVal;
}
