import 'package:createstructure/model/SettingsData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:stacked/stacked.dart';

class TutorialViewModel extends MultipleFutureViewModel {
  static const DEFAULT_FUNCTION = "DEFAULT_FUNCTION";
  SettingsData _settingsData = new SettingsData();

  @override
  Map<String, Future Function()> get futuresMap =>
      {DEFAULT_FUNCTION: defaultFunction};

  init() async {
    await _settingsData.loadData();
  }

  List<PageViewModel> getPages(BuildContext context) {
    return [
      PageViewModel(
        title: AppLocalizations.of(context)!.tutorial_page_1_title,
        body: AppLocalizations.of(context)!.tutorial_page_1_description,
        image: Image.network(AppLocalizations.of(context)!.tutorial_page_1_img),
        useScrollView: true,
      ),
    ];
  }

  Future<String> defaultFunction() async {
    return "";
  }
}
