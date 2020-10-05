import 'package:flutter/material.dart';
import 'package:news_shot/helper/platform_widgets.dart';
import 'package:news_shot/helper/size_config.dart';
import 'package:news_shot/helper/ui_helper.dart';
import 'package:news_shot/models/enums/notifier_state.dart';
import 'package:news_shot/models/source_model.dart';
import 'package:news_shot/notifiers/source_news_notifier.dart';
import 'package:news_shot/ui/common_widgets/basic_scaffold.dart';
import 'package:news_shot/ui/common_widgets/news_unit.dart';
import 'package:provider/provider.dart';

class ScreenSourceNews extends StatelessWidget {
  static const id = 'source_news';

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;

    final source = args['source'] as Sources;

    return BasicScaffold(body: Consumer<SourceNewsNotifier>(
      builder: (_, notifier, __) {
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: SizeConfig.blockSizeVertical * 8),
                  Hero(
                    tag: source.id,
                    child: getheadingWidget(
                      context: context,
                      title: source.name,
                    ),
                  ),
                  SizedBox(height: SizeConfig.blockSizeVertical),
                ],
              ),
            ),
            _newsWidget(
              context: context,
              notifier: notifier,
              source: source.id,
            ),
          ],
        );
      },
    ));
  }
}

Widget _newsWidget({
  @required BuildContext context,
  @required SourceNewsNotifier notifier,
  @required String source,
}) {
  assert(source != null);
  assert(context != null);
  assert(notifier != null);

  switch (notifier.state) {
    case NotifierState.initial:
      notifier.fetchNews(source: source);
      return SliverFillRemaining(child: getPlatformProgress());
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
            final model = notifier.model.articles[index];
            return NewsUnit(model: model);
          },
          childCount: notifier.model.articles.length,
        ),
      );
  }
}
