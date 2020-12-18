import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:injectable/injectable.dart';
import 'package:wikipidia/src/core/app_constants.dart';

@injectable
class ToastService {
  void showToast({@required String message, Color color = Colors.black87}) {
    BotToast.showText(
      text: message,
      contentColor: color,
      onlyOne: false,
      // duration: Duration(seconds: 3),
      contentPadding: EdgeInsets.only(left: 18, right: 18, top: 12, bottom: 12),
      borderRadius: BorderRadius.all(
        Radius.circular(36),
      ),
    );
  }

  void showLoading() {
    BotToast.showLoading();
  }

  void closeAllLoading() {
    BotToast.closeAllLoading();
  }
}
