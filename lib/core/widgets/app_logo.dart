import 'package:flutter/material.dart';
import 'package:nutritrack/core/theme/app_theme.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
    this.size = 40,
    this.padding = 8,
    this.backgroundColor,
    this.borderRadius,
    this.showBorder = false,
    this.fit = BoxFit.contain,
  });

  final double size;
  final double padding;
  final Color? backgroundColor;
  final double? borderRadius;
  final bool showBorder;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? size * 0.28;
    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(radius),
        border: showBorder ? Border.all(color: AppTheme.borderColor) : null,
      ),
      child: Image.asset('assets/nutrigene.png', fit: fit),
    );
  }
}
