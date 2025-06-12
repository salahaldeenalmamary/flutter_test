import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// add Padding Property to widget
extension WidgetPaddingX on Widget {
  Widget paddingAll(double padding) =>
      Padding(padding: EdgeInsets.all(padding), child: this);

  Widget paddingSymmetric({double horizontal = 0.0, double vertical = 0.0}) =>
      Padding(
          padding:
              EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
          child: this);

  Widget paddingOnly({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) =>
      Padding(
          padding: EdgeInsets.only(
              top: top, left: left, right: right, bottom: bottom),
          child: this);

  Widget get paddingZero => Padding(padding: EdgeInsets.zero, child: this);
}

/// Add margin property to widget
extension WidgetMarginX on Widget {
  Widget marginAll(double margin) =>
      Container(margin: EdgeInsets.all(margin), child: this);

  Widget marginSymmetric({double horizontal = 0.0, double vertical = 0.0}) =>
      Container(
          margin:
              EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
          child: this);

  Widget marginOnly({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) =>
      Container(
          margin: EdgeInsets.only(
              top: top, left: left, right: right, bottom: bottom),
          child: this);

  Widget get marginZero => Container(margin: EdgeInsets.zero, child: this);
  Widget decorated({
    Key? key,
    Color? color,
    DecorationImage? image,
    BoxBorder? border,
    BorderRadius? borderRadius,
    List<BoxShadow>? boxShadow,
    Gradient? gradient,
    BlendMode? backgroundBlendMode,
    BoxShape shape = BoxShape.rectangle,
    DecorationPosition position = DecorationPosition.background,
  }) {
    BoxDecoration decoration = BoxDecoration(
      color: color,
      image: image,
      border: border,
      borderRadius: borderRadius ?? BorderRadius.circular(10),
      boxShadow: boxShadow,
      gradient: gradient,
      backgroundBlendMode: backgroundBlendMode,
      shape: shape,
    );
    return DecoratedBox(
      key: key,
      decoration: decoration,
      position: position,
      child: this,
    );
  }

  Card card({
    EdgeInsetsGeometry? margin,
    BorderRadiusGeometry? borderRadius,
    double? elevation,
    Color? color,
    Color shadowColor = Colors.black12,
    Color? surfaceTintColor,
    Color borderColor = const Color(0xFFE0E0E0),
    bool borderOnForeground = true,
  }) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: margin ?? const EdgeInsets.all(16.0),
      elevation: elevation ?? 2.0,
      color: color,
      shadowColor: shadowColor,
      surfaceTintColor: surfaceTintColor,
      borderOnForeground: borderOnForeground,
      shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(10),
          side: BorderSide(color: borderColor)),
      child: this,
    );
  }

  Widget material({
    double elevation = 1.0,
    Color? shadowColor,
    Color borderColor = const Color(0xFFE0E0E0), // Colors.grey.shade200
    double borderRadius = 12.0,
    double borderWidth = 1.0,
    Clip clipBehavior = Clip.antiAlias,
  }) {
    return Material(
      elevation: elevation,
      shadowColor: shadowColor,
      clipBehavior: clipBehavior,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        side: BorderSide(
          color: borderColor,
          width: borderWidth,
        ),
      ),
      child: this,
    );
  }
}

/// Allows you to insert widgets inside a CustomScrollView
extension WidgetSliverBoxX on Widget {
  Widget get sliverBox => SliverToBoxAdapter(child: this);
}
