import 'package:flutter/material.dart';

class FLoading extends StatelessWidget {
  final double? size;
  final AlignmentGeometry? alignment;
  final Color? color;
  const FLoading({
    super.key, 
    this.size = 15, 
    this.alignment = Alignment.center,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final valueColor = color ?? Theme.of(context).colorScheme.primary;

    return Container(
      alignment: alignment ?? Alignment.center,
      height: size,
      width: size,
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(valueColor, BlendMode.srcATop),
        child: CircularProgressIndicator.adaptive(
          strokeWidth: 3,
          valueColor: AlwaysStoppedAnimation(valueColor),
        ),
      ),
    );
  }
}
