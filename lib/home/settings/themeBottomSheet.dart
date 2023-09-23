import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do/providers/config_provider.dart';
import 'package:to_do/theme.dart';

class ThemeBottomSheet extends StatefulWidget {
  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
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
              provider.changeTheme(ThemeMode.light);
              checkTheme();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.light,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: MyTheme.blackColor),
                ),
                Visibility(
                  visible: provider.isDark() ? false : true,
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
              provider.changeTheme(ThemeMode.dark);
              checkTheme();
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.dark,
                  style: provider.isDark()
                      ? Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: MyTheme.blueColor)
                      : Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: MyTheme.blackColor),
                ),
                Visibility(
                  visible: provider.isDark() ? true : false,
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
