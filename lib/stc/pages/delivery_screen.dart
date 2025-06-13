import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:webapp/stc/core/extensions/navigation_extension.dart';

import '../theme/app_styles.dart';
import '../util/image.dart';

class DeliveryScreen extends HookWidget {
  const DeliveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorTheme.background,
      body: Stack(
        children: [
          const _MapView(),
          _TrackingDetailsSheet(),
        ],
      ),
    );
  }
}

class _MapView extends StatelessWidget {
  const _MapView();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return Stack(
      children: [
        Image.asset(
          ImageConstants.map,
          width: mediaQuery.size.width,
          height: mediaQuery.size.height,
          fit: BoxFit.cover,
        ),
        CustomPaint(
          painter: _RoutePainter(),
          size: Size.infinite,
        ),
        Positioned(
          top: mediaQuery.padding.top + 16,
          left: 24,
          child: const _MapButton(icon: Icons.arrow_back_ios_new),
        ),
        Positioned(
          top: mediaQuery.padding.top + 16,
          right: 24,
          child: const _MapButton(icon: Icons.my_location),
        ),
        Positioned(
          top: mediaQuery.size.height * 0.25,
          left: mediaQuery.size.width * 0.15,
          child: const Icon(Icons.location_on,
              color: ColorTheme.primary, size: 36),
        ),
        Positioned(
          top: mediaQuery.size.height * 0.40,
          right: mediaQuery.size.width * 0.35,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
                color: ColorTheme.cardBackground,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 2))
                ]),
            child: const Icon(Icons.delivery_dining,
                color: ColorTheme.primary, size: 24),
          ),
        ),
      ],
    );
  }
}

class _MapButton extends StatelessWidget {
  final IconData icon;
  const _MapButton({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorTheme.cardBackground,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
      ),
      child: IconButton(
        icon: Icon(icon, color: ColorTheme.textPrimary, size: 20),
        onPressed: () {
          context.pop();
        },
      ),
    );
  }
}

class _RoutePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = ColorTheme.primary
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    path.moveTo(size.width * 0.18, size.height * 0.28);
    path.lineTo(size.width * 0.28, size.height * 0.28);
    path.lineTo(size.width * 0.28, size.height * 0.23);
    path.lineTo(size.width * 0.65, size.height * 0.23);
    path.lineTo(size.width * 0.65, size.height * 0.42);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _TrackingDetailsSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.55,
      minChildSize: 0.55,
      maxChildSize: 0.85,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: ColorTheme.background,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: ListView(
            controller: scrollController,
            padding: EdgeInsets.zero,
            children: [
              Gap.h8,
              Center(
                child: Container(
                  width: 40,
                  height: 5,
                  decoration: BoxDecoration(
                    color: ColorTheme.grey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Padding(
                padding:
                    AppPaddings.horizontalScreen.copyWith(top: 16, bottom: 16),
                child: Column(
                  children: const [
                    _DeliveryStatusSection(),
                    Gap.h24,
                    _OrderInfoCard(),
                    Gap.h24,
                    _CourierInfoSection(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _DeliveryStatusSection extends StatelessWidget {
  const _DeliveryStatusSection();

  @override
  Widget build(BuildContext context) {
    final greenProgressColor = Colors.green.shade500;

    return Column(
      children: [
        Text("10 minutes left", style: FontTheme.heading2),
        Gap.h8,
        Text("Delivery to Jl. Kpg Sutoyo",
            style: FontTheme.body.copyWith(color: ColorTheme.textSecondary)),
        Gap.h16,
        Row(
          children: List.generate(4, (index) {
            return Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                height: 4,
                decoration: BoxDecoration(
                  color: index < 3 ? greenProgressColor : ColorTheme.grey,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _OrderInfoCard extends StatelessWidget {
  const _OrderInfoCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorTheme.cardBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: ColorTheme.grey, width: 1.5),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: ColorTheme.primary.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(Icons.delivery_dining,
                color: ColorTheme.primary, size: 32),
          ),
          Gap.w12,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Delivered your order", style: FontTheme.title),
                Gap.h8,
                Text(
                  "We will deliver your goods to you in the shortest possible time.",
                  style: FontTheme.subtitle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CourierInfoSection extends StatelessWidget {
  const _CourierInfoSection();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=brooklyn'),
        ),
        Gap.w12,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Brooklyn Simmons", style: FontTheme.title),
              Gap.h8,
              Text("Personal Courier", style: FontTheme.subtitle),
            ],
          ),
        ),
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: ColorTheme.grey, width: 1.5),
            ),
            child: Image.asset(ImageConstants.call)),
      ],
    );
  }
}
