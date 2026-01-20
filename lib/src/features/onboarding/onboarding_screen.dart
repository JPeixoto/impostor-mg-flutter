import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../game_controller.dart';
import '../../core/theme.dart';
import '../../core/grid_background.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_app/l10n/app_localizations.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _onNext() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _finishOnboarding();
    }
  }

  void _finishOnboarding() {
    context.read<GameController>().completeOnboarding();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final loc = AppLocalizations.of(context)!;

    final pages = [
      {
        'title': loc.onboardingTitle1,
        'description': loc.onboardingDesc1,
        'icon': 'detective',
      },
      {
        'title': loc.onboardingTitle2,
        'description': loc.onboardingDesc2,
        'icon': 'secret',
      },
      {
        'title': loc.onboardingTitle3,
        'description': loc.onboardingDesc3,
        'icon': 'vote',
      },
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: GridBackground(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: theme.cardTheme.color,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: AppTheme.softShadows,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.bolt_rounded,
                                size: 18,
                                color: theme.colorScheme.primary,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                loc.onboardingAppName,
                                style: GoogleFonts.outfit(
                                  color: theme.colorScheme.onSurface,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          loc.onboardingTagline,
                          style: textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    TextButton(
                      onPressed: _finishOnboarding,
                      child: Text(
                        loc.onboardingSkip,
                        style: TextStyle(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() => _currentPage = index);
                  },
                  itemCount: pages.length,
                  itemBuilder: (context, index) {
                    final page = pages[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 24,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: theme.cardTheme.color,
                          borderRadius: BorderRadius.circular(32),
                          boxShadow: AppTheme.softShadows,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(24),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: theme.colorScheme.primary.withValues(
                                    alpha: 0.1,
                                  ),
                                ),
                                child: Icon(
                                  _getIcon(page['icon']!),
                                  size: 64,
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                              const SizedBox(height: 32),
                              Text(
                                page['title']!.toUpperCase(),
                                style: GoogleFonts.outfit(
                                  fontSize: 28,
                                  fontWeight: FontWeight.w900,
                                  color: theme.colorScheme.onSurface,
                                  letterSpacing: -1,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                page['description']!,
                                style: textTheme.bodyLarge?.copyWith(
                                  color: theme.hintColor,
                                  height: 1.5,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 32),
                              Wrap(
                                alignment: WrapAlignment.center,
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  _buildChip(loc.onboardingChip1, theme),
                                  _buildChip(loc.onboardingChip2, theme),
                                  _buildChip(loc.onboardingChip3, theme),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 28),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        pages.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 280),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          height: 8,
                          width: _currentPage == index ? 32 : 8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: _currentPage == index
                                ? theme.colorScheme.primary
                                : theme.dividerColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: _finishOnboarding,
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: theme.dividerColor),
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: Text(
                              loc.onboardingSkipTutorial,
                              style: TextStyle(
                                color: theme.colorScheme.onSurface,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _onNext,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              backgroundColor: theme.colorScheme.primary,
                              elevation: 8,
                              shadowColor: theme.colorScheme.primary.withValues(
                                alpha: 0.4,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: Text(
                              _currentPage == pages.length - 1
                                  ? loc.onboardingStartGame
                                  : loc.onboardingNext,
                              style: TextStyle(
                                color: theme.colorScheme.onPrimary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChip(String text, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.1)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: theme.colorScheme.onSurface,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  IconData _getIcon(String key) {
    switch (key) {
      case 'detective':
        return Icons.search;
      case 'secret':
        return Icons.lock;
      case 'vote':
        return Icons.how_to_vote;
      default:
        return Icons.help;
    }
  }
}
