import 'package:flutter/material.dart';
import 'package:gigpoint/widgets/cache_image.dart';

class ProductGallery extends StatelessWidget {
  const ProductGallery({Key? key, required this.imageUrl}) : super(key: key);
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 60,
          height: 224,
          child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            shrinkWrap: true,
            itemCount: 4,
            itemBuilder: (BuildContext context, int index) => SizedBox(
              height: 47,
              width: 54,
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                    index == 0 ? Colors.white : Colors.white54,
                    BlendMode.dstATop),
                child: Card(
                    color: index != 0
                        ? Colors.white
                        : const Color.fromRGBO(241, 241, 241, 1),
                    elevation: 0.1,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CacheImage(
                        imageUrl: imageUrl,
                        width: 40,
                        height: 40,
                      ),
                    )),
              ),
            ),
          ),
        ),
        const SizedBox(width: 40),
        CacheImage(
          imageUrl: imageUrl,
          height: 224,
          width: 224,
        )
      ],
    );
  }
}
