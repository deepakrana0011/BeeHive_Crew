import 'dart:io';
import 'package:beehive/constants/color_constants.dart';
import 'package:beehive/constants/image_constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ImageView extends StatelessWidget {
  final String? path;
  final double? width;
  final double? height;
  final File? file;
  final bool? circleCrop;
  final BoxFit? fit;
  final Color? color;
  final double? radius;

  const ImageView(
      {Key? key,
      this.path,
      this.width,
      this.height,
      this.file,
      this.circleCrop = false,
      this.fit,
      this.radius = 20.0,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;
    if (path == "") {
      imageWidget = Image.asset(
        ImageConstants.appLogo,
        width: width,
        height: height,
        color: ColorConstants.primaryColor,
        fit: BoxFit.contain,
      );
    } else if (path?.startsWith('http') ?? false) {
      imageWidget = CachedNetworkImage(
        fit: fit,
        height: height,
        width: width,
        imageUrl: path!,
        placeholder: (context, url) => Container(
            width: width,
            height: height,
            color: ColorConstants.primaryColor,
            child: const Center(
              child: CircularProgressIndicator(
                color: ColorConstants.colorWhite,
              ),
            ) /*Image.asset(
            ImageConstants.bg_splash,
            width: width,
            height: height,
            fit: fit,
            color: color,
          )*/
            ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      );
    } else if (path?.startsWith('assets/images/') ?? false) {
      imageWidget = path!.contains(".svg")
          ? SvgPicture.asset(
              path!,
              width: width,
              height: height,
              color: color,
            )
          : Image.asset(
              path!,
              width: width,
              height: height,
              fit: fit,
              color: color,
            );
    } else if (file != null) {
      imageWidget = Image.file(
        file!,
        width: width,
        height: height,
        fit: fit,
      );
    } else {
      imageWidget = Image.file(
        File(path.toString()),
        width: width,
        height: height,
        fit: fit,
      );
    }
    return circleCrop!
        ? CircleAvatar(radius: radius, child: ClipOval(child: imageWidget))
        : imageWidget;
  }
}
