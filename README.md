# redbook

A new Flutter project for mocking redbook app.

## translate
flutter pub run intl_translation:extract_to_arb --output-dir=lib/i18n/l10n lib/i18n/features/navi_tab_strings.dart

flutter pub pub run intl_translation:generate_from_arb --output-dir=lib/i18n/l10n --no-use-deferred-loading lib/i18n/features/*dart lib/i18n/l10n/*.arb

## model
flutter packages pub run build_runner build --delete-conflicting-outputs


## demo video
这项目当时花了半个月学了flutter做的比较粗糙，练练手，日后再优化，真机演示效果如下：

<video id="video" controls="" preload="none" poster="http://media.w3.org/2010/05/sintel/poster.png">
      <source id="mp4" src="https://github.com/cqy0000/redbook_flutter_demo/tree/main/assets/videos/demo.mp4" type="video/mp4">
      <p>redbook flutter demo video. 地址：../assets/videos/demo.mp4</p>
</video>

