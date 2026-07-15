import 'package:flutter/material.dart';

enum CategoryType {
  music,
  movie,
  series,
}

extension CategoryTypeExtension on CategoryType {
  Color get accentColor {
    switch (this) {
      case CategoryType.music:
        return const Color(0xFF0000FF); // Electric Blue
      case CategoryType.movie:
        return const Color(0xFF00D2FF); // Vibrant Cyan
      case CategoryType.series:
        return const Color(0xFFE50914); // Crimson Red
    }
  }

  String get displayName {
    switch (this) {
      case CategoryType.music:
        return 'Music';
      case CategoryType.movie:
        return 'Movie';
      case CategoryType.series:
        return 'Series';
    }
  }

  String get lowercaseLabel {
    switch (this) {
      case CategoryType.music:
        return 'music';
      case CategoryType.movie:
        return 'movies';
      case CategoryType.series:
        return 'series';
    }
  }

  // Returns raw icon for display inside selection UI elements
  Widget buildIconWidget({required Color color, double size = 24.0}) {
    switch (this) {
      case CategoryType.music:
        return Icon(Icons.audiotrack, color: color, size: size);
      case CategoryType.movie:
        return Icon(Icons.movie_filter_rounded, color: color, size: size);
      case CategoryType.series:
        // Returns a custom widget for Series icon (red vertical bands or N letter style)
        return _NetflixNIcon(color: color, size: size);
    }
  }
}

// A custom-painted letter 'N' icon to represent the series flow in style
class _NetflixNIcon extends StatelessWidget {
  final Color color;
  final double size;

  const _NetflixNIcon({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _NLogoPainter(color: color),
      ),
    );
  }
}

class _NLogoPainter extends CustomPainter {
  final Color color;

  _NLogoPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final w = size.width;
    final h = size.height;

    // Draw left vertical pillar
    final path1 = Path()
      ..moveTo(w * 0.15, h * 0.05)
      ..lineTo(w * 0.40, h * 0.05)
      ..lineTo(w * 0.40, h * 0.95)
      ..lineTo(w * 0.15, h * 0.95)
      ..close();
    canvas.drawPath(path1, paint);

    // Draw right vertical pillar
    final path2 = Path()
      ..moveTo(w * 0.60, h * 0.05)
      ..lineTo(w * 0.85, h * 0.05)
      ..lineTo(w * 0.85, h * 0.95)
      ..lineTo(w * 0.60, h * 0.95)
      ..close();
    canvas.drawPath(path2, paint);

    // Draw diagonal slash with a slightly darker tint for 3D depth, if color is crimson
    final diagonalPaint = Paint()
      ..color = Color.alphaBlend(Colors.black.withValues(alpha: 0.15), color)
      ..style = PaintingStyle.fill;

    final path3 = Path()
      ..moveTo(w * 0.15, h * 0.05)
      ..lineTo(w * 0.40, h * 0.05)
      ..lineTo(w * 0.85, h * 0.95)
      ..lineTo(w * 0.60, h * 0.95)
      ..close();
    canvas.drawPath(path3, diagonalPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
