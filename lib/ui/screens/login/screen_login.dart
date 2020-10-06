import 'package:flutter/material.dart';
import 'package:news_shot/constant/constant.dart';
import 'package:news_shot/helper/size_config.dart';
import 'package:news_shot/helper/ui_helper.dart';
import 'package:news_shot/router/router.dart';
import 'package:news_shot/ui/common_widgets/basic_scaffold.dart';

class ScreenLogin extends StatelessWidget {
  static const id = 'login';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BasicScaffold(
      backgroundColor: kColorPurple,
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            getSvgImage(
              path: kImageIcon,
              height: SizeConfig.screenWidth / 1.5,
              width: SizeConfig.screenWidth / 1.5,
            ),
            SizedBox(height: SizeConfig.blockSizeVertical * 4),
            Text(
              kAppName.toUpperCase(),
              style: TextStyle(
                fontFamily: kFontDirga,
                fontSize: SizeConfig.blockSizeVertical * 4,
              ),
            ),
            const Spacer(),
            FloatingActionButton(
              onPressed: () => launchDashboard(context: context),
              child: const Icon(Icons.arrow_forward),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
