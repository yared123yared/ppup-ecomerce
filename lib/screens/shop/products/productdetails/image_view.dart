import 'package:flutter/material.dart';
import 'package:gigpoint/widgets/appbar_widget.dart';
import 'package:gigpoint/widgets/cache_image.dart';

class ImageView extends StatefulWidget {
  const ImageView({Key? key, required this.imageUrl, required this.heroTag})
      : super(key: key);
  final String imageUrl;
  final String heroTag;

  @override
  _ImageViewState createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  Offset _offset = Offset.zero;
  Offset _initialFocalPoint = Offset.zero;
  Offset _sessionOffset = Offset.zero;

  double _scale = 1.0;
  double _initialScale = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppbarWidget(
        title: 'View Images',
      ),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: GestureDetector(
            onScaleStart: (details) {
              _initialFocalPoint = details.focalPoint;
              _initialScale = _scale;
            },
            onScaleUpdate: (details) {
              setState(() {
                _sessionOffset = details.focalPoint - _initialFocalPoint;
                _scale = _initialScale * details.scale;
              });
            },
            onScaleEnd: (details) {
              setState(() {
                _offset += _sessionOffset;
                _sessionOffset = Offset.zero;
              });
            },
            child: Transform.translate(
                offset: _offset + _sessionOffset,
                child: Transform.scale(
                    scale: _scale,
                    child: CacheImage(imageUrl: widget.imageUrl)))),
      ),
    );
  }
}
