import 'dart:async';

import '../../../navigation/navigate.dart';
import '../../../strings.dart';
import '../basis_popup_loading.dart';

Timer? _timer;

void showPopupLoading([String? loadingMsg, int? canCancelAfterSecs]) {
  final msg = loadingMsg != null ? '$loadingMsg...' : Strings.empty;

  BasisPopupLoading.show(loadingMsg: msg);

  _timer ??= Timer(
    Duration(seconds: canCancelAfterSecs ?? 45),
    () {
      Navigate.to.pop();
      BasisPopupLoading.show(loadingMsg: msg, onCancel: closePopupLoading);
    },
  );
}

void closePopupLoading() {
  _timer?.cancel();
  _timer = null;

  Navigate.to.pop();
}