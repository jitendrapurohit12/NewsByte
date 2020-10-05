import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_shot/constant/constant.dart';
import 'package:news_shot/helper/platform_widgets.dart';
import 'package:news_shot/helper/size_config.dart';
import 'package:news_shot/notifiers/category_notifier.dart';
import 'package:news_shot/notifiers/dashboard_selection_notifier.dart';
import 'package:news_shot/notifiers/news_notifier.dart';
import 'package:news_shot/notifiers/source_news_notifier.dart';
import 'package:news_shot/notifiers/source_notifier.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

final List<SingleChildWidget> providers = [
  ChangeNotifierProvider<CategoryNotifier>(create: (_) => CategoryNotifier()),
  ChangeNotifierProvider<NewsNotifier>(create: (_) => NewsNotifier()),
  ChangeNotifierProvider<SourceNotifier>(create: (_) => SourceNotifier()),
  ChangeNotifierProvider<SourceNewsNotifier>(
    create: (_) => SourceNewsNotifier(),
  ),
  ChangeNotifierProvider<DashboardSelectionNotifier>(
    create: (_) => DashboardSelectionNotifier(),
  ),
];

AppBar customAppbar({@required String title, List<Widget> actions}) {
  return AppBar(
    title: Text(title),
    actions: actions,
    centerTitle: true,
  );
}

BottomNavigationBarItem getBottomNavigationBarItem({
  @required IconData icon,
  @required String title,
}) {
  assert(title != null);
  assert(icon != null);
  return BottomNavigationBarItem(
    icon: Icon(icon),
    label: title,
  );
}

Widget getSvgImage({
  @required String path,
  double width = 24,
  double height = 24,
}) {
  return SvgPicture.asset(
    path,
    width: width,
    height: height,
  );
}

Widget noDataText({@required BuildContext context}) {
  assert(context != null);
  return Center(
    child: Text(
      'NO DATA',
      style: Theme.of(context).textTheme.headline5,
    ),
  );
}

Widget getCachedImage({@required String path}) {
  return CachedNetworkImage(
    imageUrl: path,
    fit: BoxFit.cover,
    placeholder: (_, __) => getPlatformProgress(),
    errorWidget: (_, __, ___) => Icon(
      Icons.error,
      color: Colors.red,
      size: SizeConfig.blockSizeHorizontal * 20,
    ),
  );
}

Widget errorText({@required BuildContext context}) {
  assert(context != null);
  return Center(
    child: Text(
      'SOMETHING WENT WRONG',
      style: Theme.of(context).textTheme.headline5,
    ),
  );
}

Widget getheadingWidget({
  @required BuildContext context,
  @required String title,
}) {
  assert(title != null);
  assert(context != null);
  return Padding(
    padding: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 8),
    child: Text(
      title.toUpperCase(),
      style: Theme.of(context)
          .textTheme
          .headline4
          .copyWith(fontFamily: kFontDirga),
    ),
  );
}
