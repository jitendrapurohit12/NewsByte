import 'package:flutter/material.dart';
import 'package:news_shot/constant/constant.dart';
import 'package:news_shot/helper/platform_widgets.dart';
import 'package:news_shot/helper/ui_helper.dart';
import 'package:news_shot/router/router.dart';
import 'package:news_shot/ui/screens/dashboard/screen_dashboard.dart';
import 'package:news_shot/ui/screens/login/screen_login.dart';
import 'package:provider/provider.dart';

class NewsByteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: getThemeData(),
        darkTheme: getThemeData(isLight: false),
        home: Builder(builder: (context) {
          return FutureBuilder<bool>(
            future: _getScreen(context: context),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  return snapshot.data ? ScreenDashboard() : ScreenLogin();
                default:
                  return Scaffold(
                    body: Center(
                      child: getPlatformProgress(),
                    ),
                  );
              }
            },
          );
        }),
        routes: routes,
      ),
    );
  }
}

ThemeData getThemeData({bool isLight = true}) {
  return ThemeData(
    fontFamily: kFontVarela,
    brightness: isLight ? Brightness.light : Brightness.dark,
    buttonTheme: buttonThemeData,
  );
}

final ButtonThemeData buttonThemeData = ButtonThemeData(
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(24),
  ),
  padding: const EdgeInsets.symmetric(vertical: 12),
  disabledColor: Colors.grey,
  textTheme: ButtonTextTheme.accent,
);

Future<bool> _getScreen({@required BuildContext context}) async {
  assert(context != null);
  return false;
  //return getLoginStatus(context: context);
}
