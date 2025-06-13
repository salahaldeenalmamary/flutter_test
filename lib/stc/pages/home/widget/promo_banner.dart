import 'package:flutter/material.dart';
import '../../../theme/app_styles.dart';
import '../../../util/image.dart';

class PromoBanner extends StatelessWidget {
  const PromoBanner();

  @override
  Widget build(BuildContext context) {
    return _SplitColorBannerContainer(
        child: Padding(
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
    ));
  }
}

class _SplitColorBannerContainer extends StatelessWidget {
  final Widget child;
  const _SplitColorBannerContainer({required this.child});

  final double _height = 150.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _height,
      child: Stack(
        children: [
          Column(children: [
            Expanded(
                child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF131313), Color(0xFF313131)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            )),
            Expanded(child: Container(color: Colors.white)),
          ]),
          Positioned.fill(child: child),
        ],
      ),
    );
  }
}
