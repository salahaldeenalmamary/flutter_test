import 'package:flutter/material.dart';

import '../../../theme/app_styles.dart';

class SliverHomeHeaderDelegate extends SliverPersistentHeaderDelegate {
  final TextEditingController searchController;
  final double topPadding;

  SliverHomeHeaderDelegate({
    required this.searchController,
    required this.topPadding,
  });

  @override
  double get maxExtent => topPadding + 200;

  @override
  double get minExtent => topPadding + 60;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final collapseRatio =
        (shrinkOffset / (maxExtent - minExtent)).clamp(0.0, 1.0);

    final expandedOpacity = (1 - collapseRatio * 2).clamp(0.0, 1.0);

    final collapsedOpacity = collapseRatio;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF131313), Color(0xFF313131)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Opacity(
              opacity: expandedOpacity,
              child: Padding(
                padding: AppPaddings.horizontalScreen.copyWith(bottom: 16),
                child: _SearchAndFilter(searchController: searchController),
              ),
            ),
          ),
          Positioned(
            top: Tween<double>(begin: topPadding, end: topPadding)
                .transform(collapseRatio),
            left: Tween<double>(
                    begin: AppPaddings.screen, end: AppPaddings.screen)
                .transform(collapseRatio),
            right: AppPaddings.screen,
            bottom: Tween<double>(begin: 100, end: 16).transform(collapseRatio),
            child: const _LocationHeader(),
          ),
        ],
      ),
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

class _LocationHeader extends StatelessWidget {
  const _LocationHeader();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Location',
          style: FontTheme.subtitle.copyWith(color: ColorTheme.textSecondary),
        ),
        Gap.h4,
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Bilzen, Tanjungbalai',
              style: FontTheme.body.copyWith(
                color: ColorTheme.textLight,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gap.w4,
            const Icon(
              Icons.keyboard_arrow_down,
              color: ColorTheme.textLight,
              size: 20,
            ),
          ],
        ),
      ],
    );
  }
}

class _SearchAndFilter extends StatelessWidget {
  const _SearchAndFilter({
    required this.searchController,
  });

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: searchController,
            style: FontTheme.body.copyWith(color: ColorTheme.textLight),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16,
              ),
              hintText: 'Search coffee',
              hintStyle:
                  FontTheme.body.copyWith(color: ColorTheme.textSecondary),
              prefixIcon: const Icon(Icons.search, color: ColorTheme.textLight),
              filled: true,
              fillColor: const Color(0xFF313131),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        Gap.w12,
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: ColorTheme.primary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.tune, color: Colors.white),
        ),
      ],
    );
  }
}
