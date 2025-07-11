import 'package:blog_app/core/theme/AppPallete.dart';
import 'package:flutter/material.dart';

class AuthGradeandButton extends StatelessWidget {
  final String butText;
  final VoidCallback onPress;
  const AuthGradeandButton({super.key, required this.butText, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
            colors: [
          AppPallete.gradient1,
              AppPallete.gradient2
        ],
          begin: Alignment.bottomLeft,
          end: Alignment.bottomRight,
        )
      ),
      child: ElevatedButton(

        style: ElevatedButton.styleFrom(
          backgroundColor: AppPallete.transparentColor,
          shadowColor: AppPallete.transparentColor,
          fixedSize: Size(365, 55)
        ),
          onPressed: onPress, child: Text(
          butText,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600
        ),
      )
      ),
    );
  }
}
