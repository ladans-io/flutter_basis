import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class FShimmerBase extends StatelessWidget {
  const FShimmerBase({
    super.key, 
    required this.width, 
    required this.height,
    this.radius, 
    this.baseColor, 
    this.highlightColor,
    this.color,
  });

  final double width, height;
  final double? radius;
  final Color? baseColor, highlightColor, color;

  @override
  Widget build(BuildContext context) {
    final shade300 = Colors.grey.shade300;
    
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? .0),
      child: Shimmer.fromColors(
        baseColor: baseColor ?? Colors.grey.shade200,
        highlightColor: highlightColor ?? shade300,
        child: Container(width: width, height: height, color: color ?? shade300),
      ),
    );
  }
}