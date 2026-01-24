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
    final isDark = theme.brightness == Brightness.dark;
    // Use provided color or fallback to theme defaults
    final effectiveBg = backgroundColor ?? theme.scaffoldBackgroundColor;
    final baseGrid = gridColor ?? theme.dividerColor;
    final effectiveGrid =
        gridColor ?? baseGrid.withValues(alpha: isDark ? 0.22 : 0.28);

    final primaryGlow = Color.alphaBlend(
      theme.colorScheme.primary.withValues(alpha: isDark ? 0.16 : 0.12),
      effectiveBg,
    );
    final secondaryGlow = Color.alphaBlend(
      theme.colorScheme.secondary.withValues(alpha: isDark ? 0.14 : 0.1),
      effectiveBg,
    );

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Gradient Base
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [primaryGlow, effectiveBg, secondaryGlow],
              ),
            ),
          ),
        ),
        Positioned(
          top: -140,
          left: -120,
          child: _Glow(
            color: theme.colorScheme.primary.withValues(
              alpha: isDark ? 0.22 : 0.18,
            ),
            size: 320,
          ),
        ),
        Positioned(
          bottom: -160,
          right: -120,
          child: _Glow(
            color: theme.colorScheme.secondary.withValues(
              alpha: isDark ? 0.18 : 0.14,
            ),
            size: 360,
          ),
        ),
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

class _Glow extends StatelessWidget {
  final Color color;
  final double size;

  const _Glow({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [color, color.withValues(alpha: 0.0)],
            stops: const [0.0, 1.0],
          ),
        ),
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  final Color gridColor;

  _GridPainter({required this.gridColor});

  @override
  void paint(Canvas canvas, Size size) {
    const double spacing = 46.0;
    const double strokeWidth = 0.7;

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
