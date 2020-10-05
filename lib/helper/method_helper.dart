import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news_shot/prefs/shared_prefs.dart';
import 'package:news_shot/router/router.dart';

Future<void> logout({@required BuildContext context}) async {
  await clearPrefs();
  launchLogin(context: context);
}

Future<Duration> zeroDelay() async {
  return Future.delayed(const Duration());
}
