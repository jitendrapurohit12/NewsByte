import 'package:flutter/material.dart';
import 'package:news_shot/helper/size_config.dart';
import 'package:news_shot/helper/ui_helper.dart';
import 'package:news_shot/models/news_model.dart';
import 'package:news_shot/router/router.dart';
import 'package:news_shot/style/decorations.dart';

class NewsUnit extends StatelessWidget {
  final Articles model;

  const NewsUnit({@required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: SizeConfig.blockSizeVertical,
        horizontal: SizeConfig.blockSizeVertical * 1.5,
      ),
      child: Hero(
        tag: model.title,
        child: Material(
          child: InkWell(
            borderRadius: getRadius(),
            onTap: () => launchArticle(context: context, article: model),
            child: SizedBox(
              height: SizeConfig.screenHeight / 3,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    child: model.urlToImage != null
                        ? ClipRRect(
                            borderRadius: getRadius(),
                            child: getCachedImage(path: model.urlToImage),
                          )
                        : Center(
                            child: Icon(
                              Icons.error_outline,
                              size: SizeConfig.blockSizeHorizontal * 20,
                            ),
                          ),
                  ),
                  Container(
                    decoration: kImageOverlayDecoration(),
                    child: Padding(
                      padding: EdgeInsets.all(SizeConfig.blockSizeVertical),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          model?.title ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
