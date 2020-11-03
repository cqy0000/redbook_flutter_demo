# 仿小红书App

## json-server 数据

没有后台，数据直接用json-server跑在本地localhost

```
npm i -g json-server
json-serer db.json --watch
```

## 配置国际化

```
flutter pub run intl_translation:extract_to_arb --output-dir=lib/i18n/l10n lib/i18n/features/navi_tab_strings.dart

flutter pub pub run intl_translation:generate_from_arb --output-dir=lib/i18n/l10n --no-use-deferred-loading lib/i18n/features/*dart lib/i18n/l10n/*.arb
```

## model
主要使用json_annotation 和 json_serializable
### 用json2dart将json格式的数据
### 执行脚本

```
flutter packages pub run build_runner build --delete-conflicting-outputs
```

## 效果
项目还有很多待完善的地方，如有问题，欢迎指出




## 待完善点
* 用firebase验证授权。目前登录页手机登录没有进行数据验证o(╯□╰)o~~~
* 登入页面背景循环滚动
* 商城待完善
* 列表视频的自动播放