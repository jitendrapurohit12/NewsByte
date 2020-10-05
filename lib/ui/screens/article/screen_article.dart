import 'package:flutter/material.dart';
import 'package:news_shot/helper/size_config.dart';
import 'package:news_shot/helper/ui_helper.dart';
import 'package:news_shot/models/news_model.dart';
import 'package:news_shot/style/decorations.dart';
import 'package:news_shot/ui/common_widgets/basic_scaffold.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class ScreenArticle extends StatelessWidget {
  static const id = 'article';

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;

    final model = args['article'] as Articles;

    SizeConfig().init(context);

    return BasicScaffold(
      body: CustomScrollView(
        slivers: [
          _appbar(context: context, model: model),
          _body(context: context, model: model),
        ],
      ),
    );
  }
}

Widget _body({BuildContext context, Articles model}) {
  return SliverPadding(
    padding:
        EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal * 2),
    sliver: SliverList(
      delegate: SliverChildListDelegate(
        [
          SizedBox(height: SizeConfig.blockSizeVertical * 2),
          Text(model.description, style: Theme.of(context).textTheme.headline5),
          SizedBox(height: SizeConfig.blockSizeVertical),
          Text(
            model.content,
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(height: SizeConfig.blockSizeVertical * 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FloatingActionButton.extended(
                onPressed: () => Share.share(
                  _getSharableText(title: model.title, path: model.url),
                ),
                icon: const Icon(Icons.share_outlined),
                label: const Text('Share'),
                heroTag: 'fab1',
              ),
              FloatingActionButton.extended(
                onPressed: () => launch(model.url),
                icon: const Icon(Icons.read_more),
                label: const Text('Read More'),
                heroTag: 'fab2',
              ),
            ],
          ),
          SizedBox(height: SizeConfig.blockSizeVertical * 8),
        ],
      ),
    ),
  );
}

String _getSharableText({@required String title, @required String path}) {
  assert(path != null);
  assert(title != null);

  return '$title \n\n Read More: $path';
}

Widget _appbar({BuildContext context, Articles model}) {
  return SliverAppBar(
    expandedHeight: SizeConfig.screenHeight / 3,
    pinned: true,
    flexibleSpace: FlexibleSpaceBar(
      centerTitle: true,
      title: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: SizeConfig.blockSizeHorizontal * 12,
        ),
        child: Text(
          model.title,
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(color: Colors.white),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      background: Hero(
        tag: model.title,
        child: Stack(
          fit: StackFit.expand,
          children: [
            getCachedImage(path: model.urlToImage),
            Container(
              width: double.maxFinite,
              height: SizeConfig.screenHeight / 3,
              decoration: kImageOverlayDecoration(radius: 0.0),
            ),
          ],
        ),
      ),
    ),
  );
}
