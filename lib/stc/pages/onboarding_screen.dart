
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:webapp/stc/core/extensions/navigation_extension.dart';

import '../router/route_manager.dart';
import '../theme/app_styles.dart';
import '../util/image.dart';

class OnboardingScreen extends HookWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            _buildBackgroundImage(),
            _buildContentOverlay(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return Image.asset(
     ImageConstants.Onboarding,
      fit: BoxFit.cover,
     
      color: Colors.white.withOpacity(0.3),
      colorBlendMode: BlendMode.darken,
    );
  }

  Widget _buildContentOverlay(BuildContext context) {
    final safeAreaPadding = MediaQuery.of(context).padding;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            ColorTheme.darkBackground.withOpacity(0.3),
            ColorTheme.darkBackground,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: const [0.0, 0.4, 0.6],
        ),
      ),
      child: Padding(
        padding: AppPaddings.horizontalScreen.copyWith(
          bottom: safeAreaPadding.bottom + 24,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            _TextSection(),
            Gap.h24,
            _GetStartedButton(),
          ],
        ),
      ),
    );
  }
}

class _TextSection extends StatelessWidget {
  const _TextSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Fall in Love with Coffee in Blissful Delight!',
          textAlign: TextAlign.center,
          style: FontTheme.heading1.copyWith(color: ColorTheme.textLight),
        ),
        Gap.h16,
        Text(
          'Welcome to our cozy coffee corner, where every cup is a delightful for you.',
          textAlign: TextAlign.center,
          style: FontTheme.body.copyWith(color: ColorTheme.textSecondary, height: 1.5),
        ),
      ],
    );
  }
}

class _GetStartedButton extends StatelessWidget {
  const _GetStartedButton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorTheme.primary,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: () {
           context.offAllNamed(RouteManager.homeRoute,
                 );
        },
        child: Text(
          'Get Started',
          style: FontTheme.title.copyWith(color: ColorTheme.textLight),
        ),
      ),
    );
  }
}