import 'package:flutter/material.dart';
import 'package:news_shot/constant/constant.dart';
import 'package:news_shot/helper/platform_widgets.dart';
import 'package:news_shot/helper/size_config.dart';
import 'package:news_shot/helper/ui_helper.dart';
import 'package:news_shot/models/enums/notifier_state.dart';
import 'package:news_shot/notifiers/source_notifier.dart';
import 'package:news_shot/ui/common_widgets/source_unit.dart';
import 'package:provider/provider.dart';

class PageSources extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                title: kSources,
              ),
              SizedBox(height: SizeConfig.blockSizeVertical),
            ],
          ),
        ),
        _sourceWidget(context: context),
      ],
    );
  }
}

Widget _sourceWidget({BuildContext context}) {
  return Consumer<SourceNotifier>(
    builder: (_, notifier, __) {
      switch (notifier.state) {
        case NotifierState.initial:
          notifier.fetchSource();
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
                final model = notifier.model.sources[index];
                return SourceUnit(model: model);
              },
              childCount: notifier.model.sources.length,
            ),
          );
      }
    },
  );
}
