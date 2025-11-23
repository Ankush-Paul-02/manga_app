import 'package:flutter/material.dart';
import 'package:manga_app/core/helper/ui_helper.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/utils/app_utits.dart';

class NowCard extends StatelessWidget {
  const NowCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(3.w),
          child: Image.asset(
            'assets/now.jpeg',
            width: 35.w,
            height: 25.h,
            fit: BoxFit.cover,
          ),
        ),
        UIHelper.horizontalSpace(0.8.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Attack on Titan',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              UIHelper.verticalSpace(0.02.h),
              Text(
                'Chapter 2 · Season 1',
                style: TextStyle(fontSize: 16.sp, color: Colors.white),
              ),
              UIHelper.verticalSpace(0.02.h),
              Text('Hajime Isayama', style: kGreyText),
              UIHelper.verticalSpace(0.8.h),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '69% ',
                      style: TextStyle(
                        color: kAccentColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: '· 20 min left',
                      style: kWhiteText.copyWith(fontSize: 14.sp),
                    ),
                  ],
                ),
              ),
              UIHelper.verticalSpace(0.1.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(3.w),
                child: LinearProgressIndicator(
                  value: 0.69,
                  minHeight: 8,
                  backgroundColor: Colors.grey.shade800,
                  valueColor: const AlwaysStoppedAnimation<Color>(kAccentColor),
                ),
              ),
              UIHelper.verticalSpace(0.1.h),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kAccentColor,
                  foregroundColor: Colors.black,
                  minimumSize: const Size.fromHeight(45),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3.w),
                  ),
                ),
                onPressed: () {},
                child: const Text(
                  "Continue Reading",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
