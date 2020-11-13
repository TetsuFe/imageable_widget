library imageable_widget;

import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class Imageable extends StatelessWidget {
  Imageable({this.gKey, this.child});

  final GlobalKey gKey;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: gKey,
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: child,
      ),
    );
  }
}

class ImageableController {
  final globalKey = GlobalKey();
  Widget builder(Widget child) {
    return Imageable(gKey: globalKey, child: child);
  }

  Future<ByteData> exportToImage() async {
    // 現在描画されているWidgetを取得する
    final boundary =
        globalKey.currentContext.findRenderObject() as RenderRepaintBoundary;

    // 取得したWidgetからイメージファイルをキャプチャする
    final image = await boundary.toImage(
      pixelRatio: 3,
    );

    // PNG形式化
    final byteData = await image.toByteData(
      format: ui.ImageByteFormat.png,
    );
    return byteData;
  }
}
