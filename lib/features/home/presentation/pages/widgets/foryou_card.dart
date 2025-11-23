import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:manga_app/core/helper/ui_helper.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/utils/app_utits.dart';

class ForyouCard extends StatelessWidget {
  final String image;
  final String title;
  final String chapter;

  const ForyouCard({
    super.key,
    required this.image,
    required this.title,
    required this.chapter,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 35.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(3.w),
            child: CachedNetworkImage(
              imageUrl: image,
              height: 26.h,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                height: 26.h,
                color: Colors.grey.shade800,
                child: const Center(
                  child: CircularProgressIndicator(color: kAccentColor),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                height: 200,
                color: Colors.grey.shade800,
                child: Icon(Icons.error, color: Colors.red, size: 8.w),
              ),
            ),
          ),
          UIHelper.verticalSpace(0.1),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
            ),
          ),
          Text(chapter, style: TextStyle(color: Colors.grey.shade400)),
        ],
      ),
    );
  }
}
