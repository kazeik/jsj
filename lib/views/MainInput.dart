import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jsj/utils/Utils.dart';

/**
 * @author jingsong.chen, QQ:77132995, email:kazeik@163.com
 * 2019-09-04 21:03
 * 类说明:
 */

class MainInput extends StatefulWidget {
  String hint;
  String iconPath;
  bool isPass;
  Function(String) callback;

  MainInput(
      {Key key, this.hint, this.iconPath, this.isPass = false, this.callback})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => new _MainInputState();
}

class _MainInputState extends State<MainInput> {
  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new TextField(
        decoration: new InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 1.0),
          hintText: widget.hint,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide.none),
          prefixIcon: new Padding(
            padding: EdgeInsets.all(10),
            child: new Image(
              width: 1,
              height: 1,
              image: AssetImage(
                Utils.getImgPath(widget.iconPath),
              ),
            ),
          ),
        ),
        obscureText: widget.isPass,
        onChanged: widget.callback,
      ),
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.circular(5),
        color: const Color(0xfff6f6f6),
      ),
      margin: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
    );
  }
}