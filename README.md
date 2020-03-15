# redbook

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## translate
flutter pub run intl_translation:extract_to_arb --output-dir=lib/i18n/l10n lib/i18n/features/navi_tab_strings.dart

flutter pub pub run intl_translation:generate_from_arb --output-dir=lib/i18n/l10n --no-use-deferred-loading lib/i18n/features/*dart lib/i18n/l10n/*.arb

## model
flutter packages pub run build_runner build
