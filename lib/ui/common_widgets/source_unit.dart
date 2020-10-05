import 'package:flutter/material.dart';
import 'package:news_shot/constant/constant.dart';
import 'package:news_shot/helper/size_config.dart';
import 'package:news_shot/models/source_model.dart';
import 'package:news_shot/notifiers/source_news_notifier.dart';
import 'package:news_shot/router/router.dart';
import 'package:news_shot/style/decorations.dart';
import 'package:provider/provider.dart';

class SourceUnit extends StatelessWidget {
  final Sources model;

  const SourceUnit({@required this.model});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        vertical: SizeConfig.blockSizeVertical,
        horizontal: SizeConfig.blockSizeVertical * 1.5,
      ),
      shape: imageCardShape,
      elevation: 8.0,
      child: InkWell(
        borderRadius: getRadius(),
        onTap: () async {
          final sourceNotifier =
              Provider.of<SourceNewsNotifier>(context, listen: false);
          if (sourceNotifier.sourceId != model.id) {
            await sourceNotifier.reset();
          }
          launchSourcenews(context: context, source: model);
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: SizeConfig.blockSizeVertical * 3,
            horizontal: SizeConfig.blockSizeVertical * 2,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: model.id,
                child: Text(
                  model.name,
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(fontFamily: kFontDirga),
                ),
              ),
              SizedBox(height: SizeConfig.blockSizeVertical * 2),
              Text(
                model.description,
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(fontFamily: kFontHalaney),
              )
            ],
          ),
        ),
      ),
    );
  }
}
