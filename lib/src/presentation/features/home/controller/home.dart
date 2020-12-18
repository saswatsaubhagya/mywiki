import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import 'package:wikipidia/src/core/services/toast_services.dart';
import 'package:wikipidia/src/infrastructure/models/api_error.dart';
import 'package:wikipidia/src/infrastructure/models/suggestion.dart';
import 'package:wikipidia/src/infrastructure/repository/home/home.dart';
import 'package:wikipidia/src/injection.dart';

class HomeController extends ChangeNotifier {
  var _tostService = getIt<ToastService>();
  List<Suggestion> _suggestionList = [];
  List<Suggestion> get suggestions => _suggestionList;

  Future<void> getSuggestion({String text}) async {
    _suggestionList = [];
    try {
      Either<ApiError, List<Suggestion>> suggestionResponce =
          await SuggestionImplementation().getSuggestions(text: text);
      suggestionResponce.fold(
        (error) => _tostService.showToast(message: error.error),
        (suggestions) => _suggestionList = suggestions,
      );
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
