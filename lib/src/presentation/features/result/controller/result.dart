import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:wikipidia/src/core/app_constants.dart';
import 'package:wikipidia/src/core/services/toast_services.dart';
import 'package:wikipidia/src/infrastructure/models/api_error.dart';
import 'package:wikipidia/src/infrastructure/models/apiresult.dart';
import 'package:wikipidia/src/infrastructure/repository/result/result.dart';
import 'package:wikipidia/src/injection.dart';

class ResultController extends ChangeNotifier {
  AppState _appSate = AppState.Idle;
  AppState get appState => _appSate;

  void setAppState(AppState state) {
    _appSate = state;
    notifyListeners();
  }

  PageResult _containts = new PageResult();
  PageResult get containts => _containts;

  var _tostService = getIt<ToastService>();

  Future<void> getResult({String text}) async {
    _containts = new PageResult();
    try {
      setAppState(AppState.Busy);
      _tostService.showLoading();
      Either<ApiError, PageResult> suggestionResponce =
          await ResultImplementation().getResult(titel: text);
      suggestionResponce.fold(
        (error) => _tostService.showToast(message: error.error),
        (result) => _containts = result,
      );
      setAppState(AppState.Idle);
      _tostService.closeAllLoading();
    } catch (e) {
      setAppState(AppState.Idle);
      _tostService.closeAllLoading();
      print(e);
    }
  }
}
