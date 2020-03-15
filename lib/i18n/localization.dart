import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'l10n/messages_all.dart';

import 'features/feature.dart';

class CustomLocalizations {
  final Locale locale;

  CustomLocalizations(this.locale);

  static CustomLocalizations load(Locale locale) {
    final String name = locale.countryCode.isEmpty ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    initializeMessages(localeName).then((value) {
      Intl.defaultLocale = localeName;
    });

    return CustomLocalizations(locale);
  }

  static CustomLocalizations of(BuildContext context) {
    return Localizations.of<CustomLocalizations>(context, CustomLocalizations);
  }

  static List<Locale> supportedLocales() => [
    Locale('zh', 'CN'),
    Locale('en', 'US')
  ];

  NaviTabStrings get naviTab => NaviTabStrings();
}

class CustomLocalizationsDelegate extends LocalizationsDelegate<CustomLocalizations> {
  CustomLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => CustomLocalizations.supportedLocales().contains(locale);

  @override
  Future<CustomLocalizations> load(Locale locale) => SynchronousFuture(CustomLocalizations.load(locale));

  @override
  bool shouldReload(CustomLocalizationsDelegate old) => false;
}