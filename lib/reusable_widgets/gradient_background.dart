
import 'package:flutter/material.dart';

import '../constants.dart';

class GradientBackground extends StatelessWidget {
  const GradientBackground({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.primary1,
            AppColors.primary2,
            AppColors.primary3,
          ],
        ),
      ),
    );
  }
}