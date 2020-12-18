import 'package:flutter/material.dart';
import 'package:wikipidia/app.dart';
import 'package:wikipidia/src/core/app_constants.dart';
import 'package:wikipidia/src/core/shared/apperrorwidget.dart';
import 'package:wikipidia/src/injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //handel custom error
  ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
    return AppErrorWidget(errorDetails: errorDetails);
  };
  //injectable initialization
  await configureInjection(AppConstants.ENV);
  runApp(MyApp());
}
