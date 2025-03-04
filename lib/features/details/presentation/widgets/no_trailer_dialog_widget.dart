import 'package:flutter/material.dart';
import 'package:tentwentyflix/core/config/app_colors.dart';
import 'package:tentwentyflix/core/config/app_textstyles.dart';

class NoTrailerDialogWidget extends StatelessWidget {
  const NoTrailerDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: AppColors.darkPurpleThemeColor,
              size: 50,
            ),
            const SizedBox(height: 12),
            Text(
              'Sorry. No Trailer!',
              style: AppTextstyles.headingTextPoppinsDarkPurple,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'No Trailers are available for this movie!',
              style: AppTextstyles.searchBarHintText,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.darkPurpleThemeColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Close',
                style: TextStyle(color: AppColors.whiteColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
