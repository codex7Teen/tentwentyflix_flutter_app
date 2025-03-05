import 'package:flutter/material.dart';
import 'package:tentwentyflix/core/config/app_colors.dart';
import 'package:tentwentyflix/core/config/app_textstyles.dart';
import 'package:tentwentyflix/core/utils/user_friendly_error_mapper.dart';

//! USER FRIENDLY ERROR DISPLAY WIDGET
class UserFriendlyErrorDisplayWidget extends StatelessWidget {
  final String errorMessage;
  const UserFriendlyErrorDisplayWidget({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              color: AppColors.darkPurpleThemeColor,
              size: 48,
            ),
            const SizedBox(height: 10),
            //! GETS USER FRIENDLS ERROR FROM THE URRORMAPPER UTIL
            Text(
              UserFriendlyErrorMapper.mapErrorMessage(errorMessage),
              textAlign: TextAlign.center,
              style: AppTextstyles.subHeadingTextPoppinsDarkpurple,
            ),
          ],
        ),
      ),
    );
  }
}
