import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_shot/constant/constant.dart';
import 'package:news_shot/helper/size_config.dart';
import 'package:news_shot/helper/ui_helper.dart';
import 'package:news_shot/notifiers/dashboard_selection_notifier.dart';
import 'package:news_shot/ui/common_widgets/basic_scaffold.dart';
import 'package:news_shot/ui/screens/dashboard/page_dashboard.dart';
import 'package:news_shot/ui/screens/dashboard/page_sources.dart';
import 'package:provider/provider.dart';

class ScreenDashboard extends StatelessWidget {
  static const id = 'screen_dashboard';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    final screens = [
      PageDashboard(),
      PageSources(),
    ];

    return Consumer<DashboardSelectionNotifier>(
      builder: (_, selectionNotifier, __) {
        return BasicScaffold(
          body: IndexedStack(
            index: selectionNotifier.getPage(),
            children: screens,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: selectionNotifier.getPage(),
            items: [
              getBottomNavigationBarItem(
                icon: Icons.rss_feed,
                title: kDashboard,
              ),
              getBottomNavigationBarItem(
                icon: Icons.source,
                title: kSources,
              ),
            ],
            onTap: (value) => selectionNotifier.setPage(pageNo: value),
          ),
        );
      },
    );
  }
}
