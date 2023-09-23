import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do/providers/config_provider.dart';
import 'package:to_do/theme.dart';

class LanguageBottomSheet extends StatefulWidget {
  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              provider.changeLanguage(Locale('en'));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.english,
                  style: provider.isEnglish()
                      ? Theme
                      .of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: MyTheme.blueColor)
                      : Theme
                      .of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: MyTheme.blackColor),
                ),
                Visibility(
                  visible: provider.isEnglish() ? true : false,
                  child: Icon(
                    Icons.check,
                    color: MyTheme.blueColor,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              provider.changeLanguage(Locale('ar'));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.arabic,
                  style: provider.isEnglish()
                      ? Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: MyTheme.blackColor)
                      : Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: MyTheme.blueColor),
                ),
                Visibility(
                  visible: provider.isEnglish() ? false : true,
                  child: Icon(
                    Icons.check,
                    color: MyTheme.blueColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  checkTheme() {
    Icon(
      Icons.check,
      color: MyTheme.blueColor,
    );
    setState(() {});
  }
}
