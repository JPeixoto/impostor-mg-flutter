import 'package:flutter/material.dart';
import 'package:my_app/l10n/app_localizations.dart';
import 'theme.dart';

Future<void> confirmExitToLobby(
  BuildContext context, {
  required VoidCallback onConfirm,
}) async {
  final loc = AppLocalizations.of(context)!;
  final shouldExit = await showDialog<bool>(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      final theme = Theme.of(context);
      final textTheme = theme.textTheme;
      return Dialog(
        backgroundColor: theme.colorScheme.surface,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Container(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: theme.dividerColor.withValues(alpha: 0.2),
            ),
            boxShadow: AppTheme.softShadows,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme.colorScheme.error.withValues(alpha: 0.12),
                ),
                child: Icon(
                  Icons.logout_rounded,
                  color: theme.colorScheme.error,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                loc.leaveGameTitle,
                style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                loc.leaveGameMessage,
                style: textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: theme.dividerColor.withValues(alpha: 0.5),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Text(loc.cancel),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.error,
                        foregroundColor: theme.colorScheme.onError,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 6,
                        shadowColor: theme.colorScheme.error.withValues(
                          alpha: 0.4,
                        ),
                      ),
                      child: Text(loc.backToLobby),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );

  if (shouldExit == true) {
    onConfirm();
  }
}
