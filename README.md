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

![首页](https://github.com/cqy0000/redbook_flutter_demo/blob/main/demoImg/%E9%A6%96%E9%A1%B5.png "首页")

![搜索页](https://github.com/cqy0000/redbook_flutter_demo/blob/main/demoImg/%E6%90%9C%E7%B4%A2%E9%A1%B5.png "搜索页")

![笔记详情页](https://github.com/cqy0000/redbook_flutter_demo/blob/main/demoImg/%E7%AC%94%E8%AE%B0%E8%AF%A6%E6%83%85%E9%A1%B5.png "笔记详情页")

![笔记详情页—分享](https://github.com/cqy0000/redbook_flutter_demo/blob/main/demoImg/%E7%AC%94%E8%AE%B0%E8%AF%A6%E6%83%85%E9%A1%B5_%E5%88%86%E4%BA%AB%E6%95%88%E6%9E%9C.png "笔记详情页—分享")

![消息页](https://github.com/cqy0000/redbook_flutter_demo/blob/main/demoImg/%E6%B6%88%E6%81%AF%E9%A1%B5.png "消息页")

![个人主页](https://github.com/cqy0000/redbook_flutter_demo/blob/main/demoImg/%E4%B8%AA%E4%BA%BA%E4%B8%BB%E9%A1%B5.png "个人主页")

![个人主页下拉吸顶效果](https://github.com/cqy0000/redbook_flutter_demo/blob/main/demoImg/%E4%B8%AA%E4%BA%BA%E4%B8%BB%E9%A1%B5%E4%B8%8B%E6%8B%89%E5%90%B8%E9%A1%B6%E6%95%88%E6%9E%9C.png "个人主页下拉吸顶效果")


## 待完善点
* 用firebase验证授权。目前登录页手机登录没有进行数据验证o(╯□╰)o~~~
* 登入页面背景循环滚动
* 商城待完善
* 列表视频的自动播放