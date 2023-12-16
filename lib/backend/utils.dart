T commonErrorHandler<T>(Map errObj, T rVal) {
  print('==========[ERROR OCCURED]==========');
  print(errObj.toString());
  print('===================================');
  return rVal;
}
