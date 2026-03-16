import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_app/src/core/theme.dart';

double _contrastRatio(Color a, Color b) {
  final l1 = a.computeLuminance();
  final l2 = b.computeLuminance();
  final lighter = l1 > l2 ? l1 : l2;
  final darker = l1 > l2 ? l2 : l1;
  return (lighter + 0.05) / (darker + 0.05);
}

void _expectTextContrast({
  required Color background,
  required Color foreground,
  required String label,
}) {
  expect(
    _contrastRatio(background, foreground),
    greaterThanOrEqualTo(4.5),
    reason: '$label should meet WCAG AA text contrast (4.5:1).',
  );
}

void _expectUiBoundaryContrast({
  required Color a,
  required Color b,
  required String label,
}) {
  expect(
    _contrastRatio(a, b),
    greaterThanOrEqualTo(3.0),
    reason: '$label should meet WCAG non-text contrast (3:1).',
  );
}

void main() {
  group('Theme contrast', () {
    test('light theme primary text pairs meet AA', () {
      final colorScheme = AppTheme.lightColorScheme;

      _expectTextContrast(
        background: colorScheme.primary,
        foreground: colorScheme.onPrimary,
        label: 'Primary button text',
      );
      _expectTextContrast(
        background: colorScheme.secondary,
        foreground: colorScheme.onSecondary,
        label: 'Secondary chip text',
      );
      _expectTextContrast(
        background: colorScheme.error,
        foreground: colorScheme.onError,
        label: 'Error text',
      );
      _expectTextContrast(
        background: colorScheme.surface,
        foreground: colorScheme.onSurface,
        label: 'Body text on surface',
      );
      _expectTextContrast(
        background: colorScheme.surface,
        foreground: AppTheme.lightHintColor,
        label: 'Secondary text on surface',
      );
    });

    test('dark theme primary text pairs meet AA', () {
      final colorScheme = AppTheme.darkColorScheme;

      _expectTextContrast(
        background: colorScheme.primary,
        foreground: colorScheme.onPrimary,
        label: 'Primary button text',
      );
      _expectTextContrast(
        background: colorScheme.secondary,
        foreground: colorScheme.onSecondary,
        label: 'Secondary chip text',
      );
      _expectTextContrast(
        background: colorScheme.error,
        foreground: colorScheme.onError,
        label: 'Error text',
      );
      _expectTextContrast(
        background: colorScheme.surface,
        foreground: colorScheme.onSurface,
        label: 'Body text on surface',
      );
      _expectTextContrast(
        background: colorScheme.surface,
        foreground: AppTheme.darkHintColor,
        label: 'Secondary text on surface',
      );
    });

    test('input and outlines meet non-text contrast guidance', () {
      final lightColorScheme = AppTheme.lightColorScheme;
      final darkColorScheme = AppTheme.darkColorScheme;

      _expectUiBoundaryContrast(
        a: lightColorScheme.outline,
        b: lightColorScheme.surface,
        label: 'Light outline vs surface',
      );
      _expectUiBoundaryContrast(
        a: darkColorScheme.outline,
        b: darkColorScheme.surface,
        label: 'Dark outline vs surface',
      );
      _expectUiBoundaryContrast(
        a: lightColorScheme.outline,
        b: AppTheme.lightInputFillColor,
        label: 'Light input border vs field fill',
      );
      _expectUiBoundaryContrast(
        a: darkColorScheme.outline,
        b: AppTheme.darkInputFillColor,
        label: 'Dark input border vs field fill',
      );
    });
  });
}
