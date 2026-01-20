import 'package:flutter/material.dart';

class GridBackground extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final Color? gridColor;

  const GridBackground({
    super.key,
    required this.child,
    this.backgroundColor,
    this.gridColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Use provided color or fallback to theme defaults
    final effectiveBg = backgroundColor ?? theme.scaffoldBackgroundColor;
    final effectiveGrid = gridColor ?? theme.dividerColor;

    return Stack(
      children: [
        // Base Background
        Container(color: effectiveBg),
        // Infinite Grid Pattern
        Positioned.fill(
          child: CustomPaint(painter: _GridPainter(gridColor: effectiveGrid)),
        ),
        // Content
        child,
      ],
    );
  }
}

class _GridPainter extends CustomPainter {
  final Color gridColor;

  _GridPainter({required this.gridColor});

  @override
  void paint(Canvas canvas, Size size) {
    const double spacing = 40.0;
    const double strokeWidth = 1.0;

    final paint = Paint()
      ..color = gridColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    // Draw Vertical Lines
    for (double x = 0; x <= size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Draw Horizontal Lines
    for (double y = 0; y <= size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
