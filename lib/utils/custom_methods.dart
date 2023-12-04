import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
    BuildContext context, SnackBar snackBar) {
  return ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
