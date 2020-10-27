# redbook

A new Flutter project for mocking redbook app.

## translate
flutter pub run intl_translation:extract_to_arb --output-dir=lib/i18n/l10n lib/i18n/features/navi_tab_strings.dart

flutter pub pub run intl_translation:generate_from_arb --output-dir=lib/i18n/l10n --no-use-deferred-loading lib/i18n/features/*dart lib/i18n/l10n/*.arb

## model
flutter packages pub run build_runner build --delete-conflicting-outputs
