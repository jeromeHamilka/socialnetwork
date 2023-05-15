import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../model/color_theme.dart';
import '../util/images.dart';

class ProfileImage extends InkWell {
  ProfileImage(
      {super.key,
      required String? urlString,
      required VoidCallback onPressed,
      double imageSize = 20})
      : super(
          onTap: onPressed,
          child: (urlString != null && urlString != "")
              ? CircleAvatar(
                  backgroundColor: ColorTheme().base(),
                  radius: imageSize,
                  backgroundImage: CachedNetworkImageProvider(urlString),
                )
              : CircleAvatar(
                  backgroundColor: ColorTheme().base(),
                  radius: imageSize,
                  backgroundImage: AssetImage(logoImage),
                ),
        );
}
