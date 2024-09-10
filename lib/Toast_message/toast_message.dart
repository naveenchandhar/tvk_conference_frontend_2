

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:tvk_maanadu/common/commonWidget/common_widgets.dart';

void showSuccessToast(String message, FToast fToast) {
  fToast.showToast(
    toastDuration: const Duration(seconds: 1),
    gravity: ToastGravity.CENTER,
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromRGBO(169,190,195,1),
                Color.fromRGBO(152,171,175,1),
                Color.fromRGBO(39,81,91,1)
              ])
      ),
      padding: const EdgeInsets.all(13.0),
      child: singleTitleShowingWidget(
          message,
          FontWeight.w500,
          const Color.fromRGBO(255,255,255,1),
          15.0,
          FontStyle.normal
      ),
    ),
  );
}

void showFailureToast(String message, FToast fToast) {
  fToast.showToast(
    toastDuration: const Duration(seconds: 3),
    gravity: ToastGravity.CENTER,
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromRGBO(226, 128, 123, 1.0),
                Color.fromRGBO(229, 83, 76, 1.0),
                Color.fromRGBO(220, 28, 19, 1),
              ])
      ),
      padding: const EdgeInsets.all(13.0),
      child: singleTitleShowingWidget(
          message,
          FontWeight.w500,
          const Color.fromRGBO(255,255,255,1),
          15.0,
          FontStyle.normal
      ),
    ),
  );
}