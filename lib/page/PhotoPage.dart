import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

/*
 * @author jingsong.chen, QQ:77132995, email:kazeik@163.com
 * 2019-08-23 16:23
 * 类说明:图片缩放
 */
class PhotoPage extends StatefulWidget {
  const PhotoPage({Key key, this.url}) : super(key: key);
  final String url;

  @override
  State<StatefulWidget> createState() => new _PhotoPageState();
}

class _PhotoPageState extends State<PhotoPage> {
  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: new Container(
        child: PhotoView(
          imageProvider: NetworkImage(widget.url),
        ),
      ),
    );
  }
}
