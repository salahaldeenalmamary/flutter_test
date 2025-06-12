import 'package:flutter/material.dart';
import '../../../theme/app_styles.dart';
import '../../../util/image.dart';

class PromoBanner extends StatelessWidget {
  const PromoBanner();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
          AppPaddings.screen, 24, AppPaddings.screen, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: 140,
              width: double.infinity,
              color: const Color(0xFF313131),
            ),
            Positioned.fill(
              child: Image.asset(
                ImageConstants.Banner,
                fit: BoxFit.cover,
              ),
            ),
          
          ],
        ),
      ),
    );
  }
}
