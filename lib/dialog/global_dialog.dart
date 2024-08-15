import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Future showGetDialog () {
//   return Get.dialog(
//
//   );
// }



Future<bool?> showExitConfirmationDialog() async {
  return await Get.dialog(
      AlertDialog(
      title: Text('앱 종료'),
      content: Text('앱을 종료하시겠습니까?'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Get.back(result: false),
          child: Text('아니요'),
        ),
        TextButton(
          onPressed: () => Get.back(result: true),
          child: Text('예'),
        ),
      ],
    ),
  ).then((_) => null);
}
