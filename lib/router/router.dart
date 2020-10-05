import 'package:flutter/material.dart';
import 'package:news_shot/models/news_model.dart';
import 'package:news_shot/models/source_model.dart';
import 'package:news_shot/ui/screens/article/screen_article.dart';
import 'package:news_shot/ui/screens/dashboard/screen_dashboard.dart';
import 'package:news_shot/ui/screens/login/screen_login.dart';
import 'package:news_shot/ui/screens/source_news/screen_source_news.dart';

Future<void> launchLogin({@required BuildContext context}) async {
  assert(context != null);

  Navigator.pushNamedAndRemoveUntil(
    context,
    ScreenLogin.id,
    (_) => false,
  );
}

Future<void> launchDashboard({@required BuildContext context}) async {
  assert(context != null);

  Navigator.pushNamedAndRemoveUntil(
    context,
    ScreenDashboard.id,
    (_) => false,
  );
}

Future<void> launchArticle({
  @required BuildContext context,
  @required Articles article,
}) async {
  assert(article != null);
  assert(context != null);

  final args = {'article': article};

  Navigator.pushNamed(
    context,
    ScreenArticle.id,
    arguments: args,
  );
}

Future<void> launchSourcenews({
  @required BuildContext context,
  @required Sources source,
}) async {
  assert(source != null);
  assert(context != null);

  final args = {'source': source};

  Navigator.pushNamed(
    context,
    ScreenSourceNews.id,
    arguments: args,
  );
}

// Available Routes

final Map<String, Widget Function(BuildContext)> routes = {
  ScreenLogin.id: (_) => ScreenLogin(),
  ScreenDashboard.id: (_) => ScreenDashboard(),
  ScreenArticle.id: (_) => ScreenArticle(),
  ScreenSourceNews.id: (_) => ScreenSourceNews(),
};
