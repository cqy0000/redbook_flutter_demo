import 'package:flutter/material.dart';
// import 'package:redbook/i18n/localization.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;

class NearbyPage extends StatelessWidget {
  const NearbyPage({Key key, this.labelId}): super(key: key);

  final String labelId;

  Widget build(BuildContext context) {
    return Container(
      child: Html(
        data: "<p>等了一个多月终于收到啦 <img alt='' title='icon' src='https://ci.xiaohongshu.com/xy_emo_zan.png?v=2'/> <img alt='' title='icon' src='https://ci.xiaohongshu.com/xy_emo_zan.png?v=2'/><img alt='' title='icon' src='https://ci.xiaohongshu.com/xy_emo_zan.png?v=2'/></p><p>乔治公爵 &amp; 玫瑰夫人</p>",
        customRender: (node, children) {
              if (node is dom.Element) {
                switch (node.localName) {
                  case "img":
                    return Column(children: children);
                }
              }
              return null;
            },
      )
    );
  }

}