import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myaniapp/common/dialogs/login.dart';
import 'package:myaniapp/providers/user.dart';

DateTime dateFromTimestamp(int timestamp) {
  return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
}

VoidCallback requiredLogin(
    WidgetRef ref, String action, VoidCallback callback) {
  var user = ref.read(userProvider);

  if (user.value?.data != null) return callback;

  return () => LoginDialog.show(ref.context, action);
}
