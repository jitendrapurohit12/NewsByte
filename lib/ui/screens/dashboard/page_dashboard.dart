import 'package:flutter/material.dart';
import 'package:news_shot/helper/platform_widgets.dart';
import 'package:news_shot/helper/size_config.dart';
import 'package:news_shot/helper/ui_helper.dart';
import 'package:news_shot/models/enums/notifier_state.dart';
import 'package:news_shot/notifiers/category_notifier.dart';
import 'package:news_shot/notifiers/news_notifier.dart';
import 'package:news_shot/constant/constant.dart';
import 'package:news_shot/ui/common_widgets/news_unit.dart';
import 'package:provider/provider.dart';

class PageDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<CategoryNotifier, NewsNotifier>(
      builder: (_, categoryNotifier, newsNotifier, __) {
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: SizeConfig.blockSizeVertical * 8),
                  getheadingWidget(
                    context: context,
                    title: kAppName,
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical),
                ],
              ),
            ),
            _categoryWidget(context: context, notifier: categoryNotifier),
            _newsWidget(
              context: context,
              categoryNotifier: categoryNotifier,
              newsNotifier: newsNotifier,
            ),
          ],
        );
      },
    );
  }
}

Widget _newsWidget({
  @required BuildContext context,
  @required CategoryNotifier categoryNotifier,
  @required NewsNotifier newsNotifier,
}) {
  assert(context != null);
  assert(newsNotifier != null);
  assert(categoryNotifier != null);

  if (newsNotifier.category != categoryNotifier.category) {
    newsNotifier.fetchNews(category: categoryNotifier.category);
  }

  switch (newsNotifier.state) {
    case NotifierState.initial:
    case NotifierState.fetching:
      return SliverFillRemaining(child: getPlatformProgress());
    case NotifierState.noData:
      return SliverFillRemaining(child: noDataText(context: context));
    case NotifierState.error:
      return SliverFillRemaining(child: errorText(context: context));
    case NotifierState.loaded:
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (_, index) {
            final model = newsNotifier.model.articles[index];
            return NewsUnit(model: model);
          },
          childCount: newsNotifier.model.articles.length,
        ),
      );
  }
}

Widget _categoryWidget(
    {@required BuildContext context, @required CategoryNotifier notifier}) {
  assert(notifier != null);
  assert(context != null);
  return SliverToBoxAdapter(
    child: SizedBox(
      height: SizeConfig.blockSizeVertical * 7,
      child: ListView.builder(
        itemBuilder: (_, index) {
          return Padding(
            padding: EdgeInsets.only(
              left: index == 0
                  ? SizeConfig.blockSizeHorizontal * 8
                  : SizeConfig.blockSizeHorizontal * 4,
              right: index == kCategories.length - 1
                  ? SizeConfig.blockSizeHorizontal * 4
                  : 0,
              top: SizeConfig.blockSizeVertical / 2,
              bottom: SizeConfig.blockSizeVertical / 2,
            ),
            child: ChoiceChip(
              selected: notifier.category == kCategories[index],
              elevation: 8,
              pressElevation: 8,
              label: Text(
                kCategories[index],
                style: TextStyle(color: Theme.of(context).accentColor),
              ),
              labelPadding: EdgeInsets.symmetric(
                horizontal: SizeConfig.blockSizeHorizontal * 4,
              ),
              onSelected: (value) => value
                  ? notifier.setCategory(category: kCategories[index])
                  : null,
            ),
          );
        },
        scrollDirection: Axis.horizontal,
        itemCount: kCategories.length,
      ),
    ),
  );
}
