import 'package:flutter/material.dart';

/**
 * @author jingsong.chen, QQ:77132995, email:kazeik@163.com
 * 2019-09-03 18:53
 * 类说明:
 */

class MessageInfoPage extends StatefulWidget {
  String title;
  int index;

  MessageInfoPage({Key key, @required this.title, @required this.index})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => new _MessageInfoPageState();
}

class _MessageInfoPageState extends State<MessageInfoPage> {
  @override
  Widget build(BuildContext context) {
    String msg = "";
    switch (widget.index) {
      case 0:
        msg = """用户可从服务商处购买获得JSJ币，并自动获得每次购买额度0.9%的币奖励。币会进行自动卖出消耗，每消耗一笔，则用户绑定的支付宝会到账相应币值的金额；
例如：用户购买10000元，则会到账10090JSJ币，当币完全自动卖出消耗完时，用户绑定的支付宝会累计到账10090元。
注：当币值低于1000时，应及时购买或等第二天进行购买，否则会因币不足而无法自动卖出消耗。
        """;
        break;
      case 1:
        msg =
            """用户在JSJ钱包首页点击买币，在页面选择购买服务商并填写购买金额，然后点击发起交易等待服务商接单，订单完成后币自动到账。""";
        break;
      case 2:
        msg = """用户余额里面的JSJ币会通过平台的系统自动卖出，卖出币的钱会自动到用户绑定的支付宝，平台的自动交易不收取任何交易手续费。

假如用户想停止自动卖币交易，可在JSJ钱包首页点击卖币，卖币页面会显示到账方式，以及卖出金额。用户在页面填写卖出金额（因为是手动操作，所以平台会扣除卖出金额的1%+10币），然后点击确认卖出等待平台服务商处理，服务商接单后，卖出金额会于2小时内自动到账绑定的银行卡。""";
        break;
      case 3:
        msg =
            """用户在分享页面可以看到自己的邀请码，将邀请码下载或保存到相册之后，发给朋友通过邀请码注册成功，则为分享成功。分享成功之后，将获得往下6级账户每笔积分交易金额万分之五的佣金奖励以及往下6级每人注册的会员费奖励50元。""";
        break;
    }

    return Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        elevation: 0,
      ),
      body: new Container(
        color: Colors.white,
        padding: EdgeInsets.all(20),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text("$msg"),
            new Divider(),
            new Row(
              children: <Widget>[
                new FlatButton.icon(
                  onPressed: () {},
                  label: new Text("有用"),
                  icon: new Icon(Icons.thumb_up),
                  textColor: Colors.blue,
                ),
                new FlatButton.icon(
                  onPressed: () {},
                  label: new Text("无用"),
                  icon: new Icon(Icons.thumb_down),
                  textColor: Colors.blue,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
